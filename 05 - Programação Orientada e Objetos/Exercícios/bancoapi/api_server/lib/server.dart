// -----------------------------------------------------------
// IMPORTAÇÕES
// -----------------------------------------------------------

// MySQL Client para conectar e executar queries no banco
import 'package:mysql_client/mysql_client.dart';

// Recursos de rede e sistema (usado no servidor e exceções)
import 'dart:io';

// Shelf -> núcleo do servidor HTTP
import 'package:shelf/shelf.dart';
// Shelf IO -> roda o servidor em sockets
import 'package:shelf/shelf_io.dart' as shelf_io;
// Shelf Router -> define rotas da API
import 'package:shelf_router/shelf_router.dart';


// -----------------------------------------------------------
// CONFIGURAÇÃO DE CONEXÃO COM O BANCO DE DADOS
// -----------------------------------------------------------

// Endereço e porta do servidor MySQL
const String _dbHost = '127.0.0.1';
const int _dbPort = 3306;

// Credenciais de acesso
const String _dbUser = 'david1';
const String _dbPassword = 'senha';

// Nome do banco de dados
const String _dbDatabase = 'biblioteca';


// -----------------------------------------------------------
// FUNÇÃO PARA CONEXÃO COM O BANCO
// -----------------------------------------------------------

/// Cria e retorna uma conexão MySQL
/// Retorna `null` se ocorrer algum erro
Future<MySQLConnection?> _connectToDatabase() async {
  try {
    // Cria o objeto de conexão
    final conn = await MySQLConnection.createConnection(
      host: _dbHost,
      port: _dbPort,
      userName: _dbUser,
      databaseName: _dbDatabase,
      password: _dbPassword,
      secure: false, // sem SSL
    );

    // Conecta de fato ao banco
    await conn.connect();
    return conn;
  } catch (erro) {
    print('❌ Erro ao conectar ao banco de dados: $erro');
    return null;
  }
}


// -----------------------------------------------------------
// FUNÇÃO PRINCIPAL
// -----------------------------------------------------------

void main() async {
  // Criação do roteador (controla as rotas da API)
  final Router _router = Router();

  // Porta que o servidor vai usar
  final int serverPort = 8083;


  // -------------------------------------------------------
  // ROTAS
  // -------------------------------------------------------

  /// Rota raiz ("/")
  _router.get('/', (Request request) {
    return Response.ok("Seja bem-vindo à API da biblioteca");
  });

  /// Rota para testar conexão com o banco
  _router.get('/db', (Request request) async {
    final conn = await _connectToDatabase();
    if (conn == null) {
      return Response.internalServerError(body: "Erro ao conectar ao banco");
    }

    // Executa uma query simples
    final result = await conn.execute("SELECT NOW() as data");
    await conn.close();

    return Response.ok(
      "Conexão OK - Data no banco: ${result.rows.first.colByName('data')}",
    );
  });


  // -------------------------------------------------------
  // HANDLER E PIPELINE
  // -------------------------------------------------------

  // Adiciona middlewares e define o roteador
  final handler = Pipeline()
      .addMiddleware(logRequests()) // Loga cada requisição
      .addHandler(_router.call); // Encaminha para as rotas


  // -------------------------------------------------------
  // INICIAR SERVIDOR
  // -------------------------------------------------------

  try {
    final server = await shelf_io.serve(
      handler,
      InternetAddress.loopbackIPv4, // 127.0.0.1
      serverPort,
    );

    print(
      '🚀 Servidor API ouvindo em http://${server.address.host}:${server.port}',
    );
  }

  // Tratamento de erros de rede
  on SocketException catch (erro) {
    if (erro.message.contains('permissões de acesso') ||
        erro.osError?.errorCode == 10013 || // acesso negado
        erro.osError?.errorCode == 10048 || // porta já em uso
        erro.message.contains('já está em uso') ||
        erro.message.contains('Address already in use')) {
      print('\n⚠️ Porta $serverPort já está sendo utilizada');
    } else {
      print(
        '❌ Ocorreu um erro de rede inesperado ao iniciar o servidor : $erro',
      );
    }
  }

  // Tratamento de outros erros gerais
  catch (erro) {
    print('❌ Ocorreu um erro inesperado ao iniciar o servidor : $erro');
  }
}
