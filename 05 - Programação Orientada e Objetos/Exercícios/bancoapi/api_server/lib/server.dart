import 'package:mysql_client/mysql_client.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

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

void main () async {
  final Router _router = Router();
  final int serverPort = 8083;

  ///--- Handler para a rota raiz
  _router.get('/', (Request request) {
    return  Response.ok("Seja bem-vindo à API da biblioteca");
  });

  final handler = Pipeline()
  .addMiddleware(logRequests())
  .addHandler(_router.call);

  /// Iniciar o servidor HTTP
  try {
   final server = await shelf_io.serve(
       handler,
       InternetAddress.loopbackIPv4,
       serverPort
   );
    print('Servidor API ouvindo em http://${server.address.host}:${server.port}',
    );
  } on SocketException catch(erro){
    if (erro.message.contains('permissões de acesso') ||
        erro.osError?.errorCode == 10013 ||
        erro.osError?.errorCode == 10048 ||
        error.message.contains('já está em uso') ||
        erro.message.contains('Address already in use'))                                                                                                                                                                                                                                                                                                {
          print('\nPorta $serverPort já está sendo utilizada');
    } else {
      print('Ocorreu um erro de rede inesperado ao iniciar o servidor : &erro');
    }
  }
  catch (erro) {
    print('❌ Ocorreu um erro de rede inesperado ao iniciar o servidor  : $erro');
  }
}



