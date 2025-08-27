import 'package:mysql1/mysql1.dart';

/// ----------------------------
/// Models
/// ----------------------------

/// Representa um cliente da loja
class Cliente {
  int? id; // ID do cliente (autogerado pelo MySQL)
  String nome; // Nome do cliente
  String email; // Email do cliente (único)

  /// Construtor da classe Cliente
  Cliente({this.id, required this.nome, required this.email});
}

/// Representa um pedido de um cliente
class Pedido {
  int? id; // ID do pedido (autogerado pelo MySQL)
  int clienteId; // ID do cliente que fez o pedido (chave estrangeira)
  String descricao; // Descrição do pedido
  double valor; // Valor do pedido

  /// Construtor da classe Pedido
  Pedido({
    this.id,
    required this.clienteId,
    required this.descricao,
    required this.valor,
  });
}

/// ----------------------------
/// Conexão com MySQL
/// ----------------------------

/// Função para criar e retornar uma conexão com o banco de dados MySQL
Future<MySqlConnection> getConnection() async {
  final settings = ConnectionSettings(
    host: 'localhost', // Endereço do servidor MySQL
    port: 3306, // Porta padrão do MySQL
    user: 'davidkim', // Usuário do banco
    password: 'senha', // Senha do usuário
    db: 'loja', // Nome do banco de dados
  );
  return await MySqlConnection.connect(settings);
}

/// ----------------------------
/// Funções de INSERT
/// ----------------------------

/// Insere um novo cliente no banco de dados
Future<void> inserirCliente(Cliente cliente) async {
  final conn = await getConnection();
  await conn.query('INSERT INTO Cliente (nome, email) VALUES (?, ?)', [
    cliente.nome,
    cliente.email,
  ]);
  await conn.close();
}

/// Insere um novo pedido no banco de dados
Future<void> inserirPedido(Pedido pedido) async {
  final conn = await getConnection();
  await conn.query(
    'INSERT INTO Pedido (cliente_id, descricao, valor) VALUES (?, ?, ?)',
    [pedido.clienteId, pedido.descricao, pedido.valor],
  );
  await conn.close();
}

/// ----------------------------
/// Funções de SELECT
/// ----------------------------

/// Lista todos os pedidos com os dados do cliente correspondente
Future<void> listarPedidosComClientes() async {
  final conn = await getConnection();
  var results = await conn.query('''
    SELECT Pedido.id, Pedido.descricao, Pedido.valor, Cliente.nome, Cliente.email
    FROM Pedido
    INNER JOIN Cliente ON Pedido.cliente_id = Cliente.id
  ''');

  // Exibe cada pedido no console
  for (var row in results) {
    print(
      'Pedido #${row[0]} - ${row[1]} | R\$${row[2]} - Cliente: ${row[3]} (${row[4]})',
    );
  }
  await conn.close();
}

/// Mostra um resumo do total gasto por cada cliente
Future<void> resumoPedidosPorCliente() async {
  final conn = await getConnection();
  var results = await conn.query('''
    SELECT Cliente.nome, SUM(Pedido.valor) AS total_gasto
    FROM Cliente
    INNER JOIN Pedido ON Cliente.id = Pedido.cliente_id
    GROUP BY Cliente.nome
  ''');

  // Exibe o total gasto por cliente no console
  for (var row in results) {
    print('Cliente: ${row[0]} - Total Gasto: R\$${row[1]}');
  }
  await conn.close();
}

/// ----------------------------
/// Main
/// ----------------------------

/// Função principal do programa
/// Executa inserções e consultas no banco de dados
void main() async {
  // ----------------------------
  // Inserção de clientes exemplo
  // ----------------------------
  /*
  
  await inserirCliente(Cliente(nome: 'João Silva', email: 'joao@email.com'));
  await inserirCliente(Cliente(nome: 'Maria Souza', email: 'maria@email.com'));
  
  */

  // ----------------------------
  // Inserção de pedidos exemplo
  // ----------------------------

  /*
  await inserirPedido(
    Pedido(clienteId: 1, descricao: 'Notebook', valor: 3500.00),
  );
  await inserirPedido(
    Pedido(clienteId: 1, descricao: 'Mouse', valor: 150.00),
  );
  await inserirPedido(
    Pedido(clienteId: 2, descricao: 'Celular', valor: 2200.00),
  );
  */

  // ----------------------------
  // Consultas e exibição no console
  // ----------------------------
  print('\n--- Listagem de Pedidos com Clientes ---');
  await listarPedidosComClientes();

  print('\n--- Resumo de Pedidos por Cliente ---');
  await resumoPedidosPorCliente();
}
