import 'dart:io';

void main() {
  // Solicita o nome do produto ao usuário
  stdout.write('Digite o nome do produto: ');
  String? nome = stdin.readLineSync();

  double? preco;

  // Loop para garantir que o usuário digite um preço válido
  while (true) {
    stdout.write('Digite o preço do produto: ');
    String? entrada = stdin.readLineSync();

    // Tenta converter a entrada em número decimal (double)
    preco = double.tryParse(entrada ?? '');

    // Verifica se o preço é válido (não nulo e positivo)
    if (preco == null || preco < 0) {
      print('❌ Erro: Digite um preço válido (use ponto em vez de vírgula).');
    } else {
      break; // Sai do loop se for válido
    }
  }

  // Cria o produto e mostra os dados formatados
  Produto produto = Produto(nome?.trim().isNotEmpty == true ? nome! : 'Sem nome', preco);
  produto.mostrarDados();
}

// Classe Produto com encapsulamento do atributo _preco
class Produto {
  String nome;
  double _preco = 0.0;

  // Construtor recebe nome e preço
  Produto(this.nome, double preco) {
    this.preco = preco; // Usa o setter para aplicar validação
  }

  // Getter para obter o valor do preço
  double get preco => _preco;

  // Setter com validação para evitar preços negativos
  set preco(double valor) {
    if (valor >= 0) {
      _preco = valor;
    } else {
      print('⚠️ Preço inválido! Mantendo valor anterior.');
    }
  }

  // Exibe os dados do produto formatados
  void mostrarDados() {
    print('🛒 Produto: $nome | 💰 Preço: R\$ ${_preco.toStringAsFixed(2)}');
  }
}
