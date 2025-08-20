// Bibliotecas padrão do Dart
import 'dart:io';        // Para manipular rede, portas e servidor
import 'dart:convert';   // Para trabalhar com JSON e UTF-8

// Dependências externas
import 'package:mysql_client/mysql_client.dart';  // Cliente MySQL para Dart
import 'package:shelf/shelf.dart';                // Core do framework Shelf (para APIs)
import 'package:shelf/shelf_io.dart' as shelf_io; // Para subir o servidor Shelf
import 'package:shelf_router/shelf_router.dart';  // Para criar rotas de forma simples

// --- Configurações de Conexão com o Banco ---
const String _dbHost = '127.0.0.1';
const int _dbPort = 3306;
const String _dbUser = 'david1';
const String _dbPassword = 'senha';
const String _dbDatabase = 'biblioteca';

// Função para criar e abrir conexão com o banco
Future<MySQLConnection?> _connectToDatabase() async {
  try {
    final conn = await MySQLConnection.createConnection(
      host: _dbHost,
      port: _dbPort,
      userName: _dbUser,
      databaseName: _dbDatabase,
      password: _dbPassword,
      secure: false,
    );
    await conn.connect(); // efetivamente conecta
    return conn;
  } catch (erro) {
    print('Erro ao conectar ao banco de dados: $erro');
    return null;
  }
}

void main() async {
  // Instância do roteador
  final Router _router = Router();

  // Porta do servidor HTTP
  final int serverPort = 8085; // configurável

  // -------------------------------
  // --- ROTAS DA API BIBLIOTECA ---
  // -------------------------------

  // Rota inicial (GET /)
  _router.get('/', (Request request) {
    return Response.ok('Bem-vindo à API da Biblioteca!');
  });

  // Listar todos os livros (GET /livros)
  _router.get('/livros', (Request request) async {
    final conn = await _connectToDatabase();
    if (conn == null) {
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro ao conectar ao banco de dados.'}),
      );
    }

    try {
      var resultado = await conn.execute(
        'select idlivro,titulo,autor from livros order by idlivro',
      );

      // Se não houver resultados, retorna array vazio
      if (resultado.rows.isEmpty) {
        return Response.ok(
          jsonEncode([]),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
        );
      }

      // Monta lista de mapas para JSON
      final List<Map<String, dynamic>> livros = [];
      for (var linha in resultado.rows) {
        livros.add({
          'id': linha.typedColByName<int>('idlivro'),
          'titulo': linha.typedColByName<String>('titulo'),
          'autor': linha.typedColByName<String>('autor'),
        });
      }

      return Response.ok(
        jsonEncode(livros),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
    } catch (e) {
      print('Erro ao listar livros na API: $e');
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro interno ao listar livros.'}),
      );
    } finally {
      await conn.close(); // Fecha conexão
    }
  });

  // Incluir um novo livros (POST /livros)
  _router.post('/livros', (Request request) async {
    final conn = await _connectToDatabase();
    if (conn == null) {
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro ao conectar ao banco de dados.'}),
      );
    }

    try {
      final String content = await utf8.decodeStream(request.read());
      if (content.isEmpty) {
        return Response.badRequest(
          body: jsonEncode({'message': 'Corpo da requisição vazio.'}),
        );
      }

      final Map<String, dynamic> body = jsonDecode(content);

      final String? titulo = body['titulo'] as String?;
      final String? autor = body['autor'] as String?;

      // Validação
      if (titulo == null || autor == null || titulo.isEmpty || autor.isEmpty) {
        return Response.badRequest(
          body: jsonEncode({'message': 'Título e autor são obrigatórios.'}),
        );
      }

      // Executa insert no banco
      var result = await conn.execute(
        'insert into livros (titulo,autor) values (:titulo,:autor)',
        {'titulo': titulo, 'autor': autor},
      );

      return Response(
        HttpStatus.created, // 201 Created
        body: jsonEncode({
          'message': 'Livro incluído com sucesso!',
          'id': result.lastInsertID.toInt(), // ID do novo registro
        }),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
    } catch (e) {
      print('Erro ao incluir livro na API: $e');
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro interno ao incluir livro.'}),
      );
    } finally {
      await conn.close();
    }
  });

  // Buscar livro por ID (GET /livros/{id})
  _router.get('/livros/<id>', (Request request, String id) async {
    final conn = await _connectToDatabase();
    if (conn == null) {
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro ao conectar ao banco de dados.'}),
      );
    }

    try {
      final int? livroId = int.tryParse(id);
      if (livroId == null) {
        return Response.badRequest(
          body: jsonEncode({'message': 'ID do livro inválido.'}),
        );
      }

      var resultado = await conn.execute(
        'select idlivro,titulo,autor from livros where idlivro = :id',
        {'id': livroId},
      );

      if (resultado.rows.isEmpty) {
        return Response.notFound(
          jsonEncode({'message': 'Livro não encontrado.'}),
        );
      }

      final linha = resultado.rows.first;
      final livro = {
        'id': linha.typedColByName<int>('idlivro'),
        'titulo': linha.typedColByName<String>('titulo'),
        'autor': linha.typedColByName<String>('autor'),
      };

      return Response.ok(
        jsonEncode(livro),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
    } catch (e) {
      print('Erro ao buscar livro por ID na API: $e');
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro interno ao buscar livro.'}),
      );
    } finally {
      await conn.close();
    }
  });

  // Atualizar livro (PUT /livros/{id})
  _router.put('/livros/<id>', (Request request, String id) async {
    final conn = await _connectToDatabase();
    if (conn == null) {
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro ao conectar ao banco de dados.'}),
      );
    }

    try {
      final int? livroId = int.tryParse(id);
      if (livroId == null) {
        return Response.badRequest(
          body: jsonEncode({'message': 'ID do livro inválido.'}),
        );
      }

      final String content = await utf8.decodeStream(request.read());
      if (content.isEmpty) {
        return Response.badRequest(
          body: jsonEncode({'message': 'Corpo da requisição vazio.'}),
        );
      }

      final Map<String, dynamic> body = jsonDecode(content);
      final String? titulo = body['titulo'] as String?;
      final String? autor = body['autor'] as String?;

      if (titulo == null || autor == null || titulo.isEmpty || autor.isEmpty) {
        return Response.badRequest(
          body: jsonEncode({
            'message': 'Título e autor são obrigatórios para atualização.',
          }),
        );
      }

      // Executa UPDATE
      var result = await conn.execute(
        'update livros set titulo = :titulo, autor = :autor where id = :id',
        {'titulo': titulo, 'autor': autor, 'id': id},
      );

      if (result.affectedRows == 0) {
        return Response.notFound(
          jsonEncode({
            'message': 'Livro com ID $livroId não encontrado para atualização.',
          }),
        );
      }

      return Response.ok(
        jsonEncode({'message': 'Livro atualizado com sucesso!'}),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
    } catch (e) {
      print('Erro ao atualizar livro na API: $e');
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro interno ao atualizar livro.'}),
      );
    } finally {
      await conn.close();
    }
  });

  // Excluir livro (DELETE /livros/{id})
  _router.delete('/livros/<id>', (Request request, String id) async {
    final conn = await _connectToDatabase();
    if (conn == null) {
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro ao conectar ao banco de dados.'}),
      );
    }

    try {
      final int? livroId = int.tryParse(id);
      if (livroId == null) {
        return Response.badRequest(
          body: jsonEncode({'message': 'ID do livro inválido.'}),
        );
      }

      var result = await conn.execute(
        'delete from livros where idlivro = :id',
        {'id': livroId},
      );

      if (result.affectedRows == 0) {
        return Response.notFound(
          jsonEncode({
            'message': 'Livro com ID $livroId não encontrado para exclusão.',
          }),
        );
      }

      return Response(HttpStatus.noContent); // 204 - sem corpo
    } catch (e) {
      print('Erro ao excluir livro na API: $e');
      return Response.internalServerError(
        body: jsonEncode({'message': 'Erro interno ao excluir livro.'}),
      );
    } finally {
      await conn.close();
    }
  });

  // -------------------------------
  // --- SERVIDOR HTTP COM SHELF ---
  // -------------------------------

  // Middleware para logar todas as requisições
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(_router.call);

  // Inicia o servidor
  try {
    final server = await shelf_io.serve(
      handler,
      InternetAddress.loopbackIPv4, // localhost (127.0.0.1)
      serverPort,
    );
    print(
      'Servidor API ouvindo em http://${server.address.host}:${server.port}',
    );
  } on SocketException catch (e) {
    // Tratamento específico para erros de porta ocupada ou permissão
    if (e.message.contains('permissões de acesso') ||
        e.osError?.errorCode == 10013 ||
        e.osError?.errorCode == 10048 ||
        e.message.contains('já está em uso') ||
        e.message.contains('Address already in use')) {
      print(
        '\n========================================================================',
      );
      print(
        'ERRO: A porta $serverPort já está em uso ou você não tem permissão para usá-la.',
      );
      print('Por favor, verifique se outro programa está utilizando a porta.');
      print('Você pode tentar:');
      print(
        '  1. Mudar a porta no código (ex: para 8081, 9000, etc.) e reiniciar o servidor.',
      );
      print('  2. Fechar o programa que está usando a porta $serverPort.');
      print(
        '========================================================================\n',
      );
    } else {
      print('Ocorreu um erro de rede inesperado ao iniciar o servidor: $e');
    }
  } catch (e) {
    print('Ocorreu um erro inesperado ao iniciar o servidor: $e');
  }
}
