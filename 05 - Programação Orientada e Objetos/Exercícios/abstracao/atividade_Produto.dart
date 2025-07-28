import 'dart:io';

void main() {
  stdout.write('Digite o nome do produto: ');
  String? nome = stdin.readLineSync();

  double? preco;

  // Validação do preço
  while (true) {
    stdout.write('Digite o preço do produto: ');
    String? entrada = stdin.readLineSync();

    preco = double.tryParse(entrada ?? '');

    if (preco == null || preco < 0) {
      print('Erro: Digite um preço válido (número positivo, sem virgula, com ponto).');
    } else {
      break;
    }
  }

  // Cria o produto e mostra os dados
  Produto produto = Produto(nome ?? 'Sem nome', preco);
  produto.mostrarDados();
}

class Produto {
  String nome;
  double _preco = 0.0;

  Produto(this.nome, double preco) {
    this.preco = preco;
  }

  double get preco => _preco;

  set preco(double valor) {
    if (valor >= 0) {
      _preco = valor;
    } else {
      print('Preço inválido!');
    }
  }

  void mostrarDados() {
    print('Produto: $nome | Preço: R\$ ${_preco.toStringAsFixed(2)}');
  }
}
