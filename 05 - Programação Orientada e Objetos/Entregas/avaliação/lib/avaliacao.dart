import 'package:mysql1/mysql1.dart';

/// ----------------------------
/// Classe Produto
/// ----------------------------
class Produto {
  String nome;
  double _preco;

  /// Construtor com validação de preço
  Produto({required this.nome, required double preco})
    : _preco = preco >= 0 ? preco : 0 {
    if (preco < 0) {
      print('Preço negativo não permitido! Definido como 0.');
    }
  }

  /// Getter do preço
  double get preco => _preco;

  /// Setter do preço com validação
  set preco(double valor) {
    if (valor >= 0) {
      _preco = valor;
    } else {
      print('Preço negativo não permitido! Valor não alterado.');
    }
  }

  /// Método para exibir informações do produto
  void exibir() {
    print('Produto: $nome | Preço: R\$${_preco.toStringAsFixed(2)}');
  }
}

/// ----------------------------
/// Conexão com MySQL
/// ----------------------------
Future<MySqlConnection> getConnection() async {
  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'davidkim',
    password: 'senha',
    db: 'loja_produtos',
  );
  return await MySqlConnection.connect(settings);
}

/// ----------------------------
/// Funções para manipular banco
/// ----------------------------

/// Insere um produto no banco
Future<void> inserirProduto(Produto produto) async {
  final conn = await getConnection();
  await conn.query('INSERT INTO Produto (nome, preco) VALUES (?, ?)', [
    produto.nome,
    produto.preco,
  ]);
  await conn.close();
}

/// Lista todos os produtos do banco
Future<void> listarProdutos() async {
  final conn = await getConnection();
  var results = await conn.query('SELECT * FROM Produto');

  for (var row in results) {
    print('Produto #${row[0]} - ${row[1]} | R\$${row[2]}');
  }
  await conn.close();
}

/// ----------------------------
/// Função principal
/// ----------------------------
void main() async {
  // Criando produtos
  Produto produto1 = Produto(nome: 'Notebook', preco: 3500.00);
  Produto produto2 = Produto(nome: 'Mouse', preco: 150.00);

  // Tentativa de definir preço negativo (testa validação)
  produto2.preco = -50.00; // Não será alterado
  produto1.preco = 3600.00; // Alteração válida

  // Exibindo no console (OOP)
  print('--- Produtos Criados (OOP) ---');
  produto1.exibir();
  produto2.exibir();

  // Inserindo no banco de dados
  await inserirProduto(produto1);
  await inserirProduto(produto2);

  // Listando produtos do banco
  print('\n--- Produtos no Banco de Dados ---');
  await listarProdutos();
}
