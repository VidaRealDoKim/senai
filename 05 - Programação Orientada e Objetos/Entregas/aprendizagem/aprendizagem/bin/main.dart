import 'package:mysql1/mysql1.dart';

// ----------------------------
// Models
// ----------------------------
class Cliente {
  int? id;
  String nome;
  String email;

  Cliente({this.id, required this.nome, required this.email});
}

class Pedido {
  int? id;
  int clienteId;
  String descricao;
  double valor;

  Pedido({
    this.id,
    required this.clienteId,
    required this.descricao,
    required this.valor,
  });
}

// ----------------------------
// Conexão com MySQL
// ----------------------------
Future<MySqlConnection> getConnection() async {
  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'davidkim',
    password: 'senha', // <- Troque aqui
    db: 'loja',
  );
  return await MySqlConnection.connect(settings);
}

// ----------------------------
// Funções de INSERT
// ----------------------------
Future<void> inserirCliente(Cliente cliente) async {
  final conn = await getConnection();
  await conn.query('INSERT INTO Cliente (nome, email) VALUES (?, ?)', [
    cliente.nome,
    cliente.email,
  ]);
  await conn.close();
}

Future<void> inserirPedido(Pedido pedido) async {
  final conn = await getConnection();
  await conn.query(
    'INSERT INTO Pedido (cliente_id, descricao, valor) VALUES (?, ?, ?)',
    [pedido.clienteId, pedido.descricao, pedido.valor],
  );
  await conn.close();
}

// ----------------------------
// Funções de SELECT
// ----------------------------
Future<void> listarPedidosComClientes() async {
  final conn = await getConnection();
  var results = await conn.query('''
    SELECT Pedido.id, Pedido.descricao, Pedido.valor, Cliente.nome, Cliente.email
    FROM Pedido
    INNER JOIN Cliente ON Pedido.cliente_id = Cliente.id
  ''');

  for (var row in results) {
    print(
      'Pedido #${row[0]} - ${row[1]} | R\$${row[2]} - Cliente: ${row[3]} (${row[4]})',
    );
  }
  await conn.close();
}

Future<void> resumoPedidosPorCliente() async {
  final conn = await getConnection();
  var results = await conn.query('''
    SELECT Cliente.nome, SUM(Pedido.valor) AS total_gasto
    FROM Cliente
    INNER JOIN Pedido ON Cliente.id = Pedido.cliente_id
    GROUP BY Cliente.nome
  ''');

  for (var row in results) {
    print('Cliente: ${row[0]} - Total Gasto: R\$${row[1]}');
  }
  await conn.close();
}

// ----------------------------
// Main
// ----------------------------
void main() async {
  // Criando clientes
  await inserirCliente(Cliente(nome: 'João Silva', email: 'joao@email.com'));
  await inserirCliente(Cliente(nome: 'Maria Souza', email: 'maria@email.com'));

  // Criando pedidos
  await inserirPedido(
    Pedido(clienteId: 1, descricao: 'Notebook', valor: 3500.00),
  );
  await inserirPedido(Pedido(clienteId: 1, descricao: 'Mouse', valor: 150.00));
  await inserirPedido(
    Pedido(clienteId: 2, descricao: 'Celular', valor: 2200.00),
  );

  // Consultas
  print('\n--- Listagem de Pedidos com Clientes ---');
  await listarPedidosComClientes();

  print('\n--- Resumo de Pedidos por Cliente ---');
  await resumoPedidosPorCliente();
}
