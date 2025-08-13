import 'package:mysql_client/mysql_client.dart';

// Configuração de conexão com banco de dados
// Diretivas para conexão com o banco
const String _dbHost = '127.0.0.1'; // localhost
const int _dbPort = 3306;

// diretivas do usuário e o nome do database (altere conforme a sua necessidade)
const String _dbUser = 'marcio';
const String _dbPassword = 'senha';
const String _dbDatabase = 'biblioteca';
void main() async {
  // Inicializa a conexão com o banco de dados
  final conn = await _connectToDatabase();

  if (conn == null) {
    print('Não foi possível estabelecer conexão com o banco de dados.');
    return;
  }

  print('Conectado ao banco de dados');

  try {
    print('\n--- Incluindo Livro ---');
    await _incluirLivro(
      conn,
      'As Louras Tranças de Um Careca',
      'Winston Churchill',
    );
  } catch (erro) {
    print('Ocorreu na inclusão do livro: $erro');
  }

  try {
    print('\n--- Listando Livros ---');
    await _listarLivros(conn);
  } catch (erro) {
    print('Ocorreu na listagem dos livros: $erro');
  } finally {
    await conn.close();
    print('Conexão com o MySQL fechada.');
  }
}

// --- Funções CRUD ---

Future<MySQLConnection?> _connectToDatabase() async {
  try {
    // Usando MySQLConnection.createConnection para uma abordagem mais moderna
    final conn = await MySQLConnection.createConnection(
      host: _dbHost,
      port: _dbPort,
      userName: _dbUser,
      databaseName: _dbDatabase,
      password: _dbPassword,
    );
    await conn.connect();
    return conn;
  } catch (erro) {
    print('Erro ao conectar ao banco de dados: $erro');
    return null;
  }
}

Future<void> _incluirLivro(
  MySQLConnection conn,
  String titulo,
  String autor,
) async {
  try {
    var result = await conn.execute(
      'insert into livros (titulo,autor) values (:titulo,:autor)',
      {'titulo': titulo, 'autor': autor},
    );
    print('Livro incluido com sucesso');
  } catch (erro) {
    print('Inclusão com problema $erro');
  }
}

Future<void> _listarLivros(MySQLConnection conn) async {
  try {
    var resultado = await conn.execute(
      'select idlivro,titulo,autor from livros order by idlivro',
    );

    if (resultado.rows.isEmpty) {
      print('Cara. Não achei nada');
      return;
    }

    for (var linha in resultado.rows) {
      final id = linha.typedColByName<int>('idlivro');
      final titulo = linha.typedColByName<String>('titulo');
      final autor = linha.typedColByName<String>('autor');
      print('Id: $id, Titulo: $titulo,  Autor: $autor');
    }
  } catch (erro) {
    print('Erro ao listar livros $erro');
  }
}
