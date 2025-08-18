import 'package:mysql_client/mysql_client.dart';

/// -----------------------------------------------------------
/// CONFIGURAÇÃO DE CONEXÃO COM O BANCO DE DADOS
/// -----------------------------------------------------------

// Endereço do servidor de banco de dados (127.0.0.1 é localhost)
const String _dbHost = '127.0.0.1';
// Porta padrão do MySQL
const int _dbPort = 3306;

// Credenciais de acesso e nome do banco de dados
const String _dbUser = 'david1';
const String _dbPassword = 'senha';
const String _dbDatabase = 'biblioteca';

/// -----------------------------------------------------------
/// FUNÇÃO PRINCIPAL
/// -----------------------------------------------------------
void main() async {
  // Tenta estabelecer conexão
  final conn = await _connectToDatabase();

  if (conn == null) {
    print('❌ Não foi possível estabelecer conexão com o banco de dados.');
    return;
  }

  print('✅ Conectado ao banco de dados');

  // Tentativa de inclusão de livro
  try {
    print('\n--- Incluindo Livro ---');
    await _incluirLivro(
      conn,
      'As Louras Tranças de Um Careca',
      'Winston Churchill',
    );
  } catch (erro) {
    print('❌ Ocorreu um erro na inclusão do livro: $erro');
  }

  // Tentativa de listagem dos livros
  try {
    print('\n--- Listando Livros ---');
    await _listarLivros(conn);
  } catch (erro) {
    print('❌ Ocorreu um erro na listagem dos livros: $erro');
  } finally {
    // Sempre fecha a conexão no final
    await conn.close();
    print('🔒 Conexão com o MySQL fechada.');
  }
}

/// -----------------------------------------------------------
/// FUNÇÕES DE CONEXÃO
/// -----------------------------------------------------------

/// Conecta ao banco de dados e retorna um objeto [MySQLConnection]
Future<MySQLConnection?> _connectToDatabase() async {
  try {
    // Cria a conexão usando parâmetros configurados
    final conn = await MySQLConnection.createConnection(
      host: _dbHost,
      port: _dbPort,
      userName: _dbUser,
      databaseName: _dbDatabase,
      password: _dbPassword,
      secure: false,
    );

    // Estabelece a conexão
    await conn.connect();
    return conn;
  } catch (erro) {
    print('❌ Erro ao conectar ao banco de dados: $erro');
    return null;
  }
}

/// -----------------------------------------------------------
/// FUNÇÕES CRUD
/// -----------------------------------------------------------

/// Inclui um livro na tabela `livros`
Future<void> _incluirLivro(
    MySQLConnection conn,
    String titulo,
    String autor,
    ) async {
  try {
    await conn.execute(
      // Usando parâmetros nomeados para evitar SQL Injection
      'INSERT INTO livros (titulo, autor) VALUES (:titulo, :autor)',
      {'titulo': titulo, 'autor': autor},
    );
    print('📚 Livro incluído com sucesso!');
  } catch (erro) {
    print('❌ Erro na inclusão do livro: $erro');
  }
}

/// Lista todos os livros da tabela `livros`
Future<void> _listarLivros(MySQLConnection conn) async {
  try {
    final resultado = await conn.execute(
      'SELECT idlivro, titulo, autor FROM livros ORDER BY idlivro',
    );

    // Caso a tabela esteja vazia
    if (resultado.rows.isEmpty) {
      print('⚠️ Nenhum livro encontrado.');
      return;
    }

    // Percorre e exibe cada linha da consulta
    for (var linha in resultado.rows) {
      final id = linha.typedColByName<int>('idlivro');
      final titulo = linha.typedColByName<String>('titulo');
      final autor = linha.typedColByName<String>('autor');
      print('Id: $id | Título: $titulo | Autor: $autor');
    }
  } catch (erro) {
    print('❌ Erro ao listar livros: $erro');
  }
}
