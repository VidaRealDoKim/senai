import 'dart:io'; // Importa a biblioteca para entrada e saída via terminal

// Define a classe Produto com atributos privados
class Produto {
  String _nome;       // Atributo privado para o nome do produto
  double _preco;      // Atributo privado para o preço do produto
  int _quantidade;    // Atributo privado para a quantidade em estoque

  // Construtor que inicializa os atributos nome, preço e quantidade
  Produto(this._nome, this._preco, this._quantidade);

  // Método que calcula o valor total do produto no estoque
  double valorTotalEstoque() => _preco * _quantidade;
}

// Função principal para executar o exercício 1
Future<void> executarExercicio1() async {
  print('\n=== Exercício 1: Produto ==='); // Mostra título do exercício no terminal

  stdout.write('Nome do produto: ');      // Solicita nome do produto
  String nome = stdin.readLineSync() ?? ''; // Lê a entrada do usuário (string)

  stdout.write('Preço do produto: ');     // Solicita preço do produto
  double preco = double.tryParse(stdin.readLineSync() ?? '') ?? 0; // Lê e converte para double (preço)

  stdout.write('Quantidade em estoque: ');  // Solicita quantidade em estoque
  int quantidade = int.tryParse(stdin.readLineSync() ?? '') ?? 0;  // Lê e converte para int (quantidade)

  // Cria um objeto Produto com os dados fornecidos
  var produto = Produto(nome, preco, quantidade);

  // Calcula e imprime o valor total do estoque formatado com 2 casas decimais
  print('Valor total em estoque: R\$ ${produto.valorTotalEstoque().toStringAsFixed(2)}');
}
