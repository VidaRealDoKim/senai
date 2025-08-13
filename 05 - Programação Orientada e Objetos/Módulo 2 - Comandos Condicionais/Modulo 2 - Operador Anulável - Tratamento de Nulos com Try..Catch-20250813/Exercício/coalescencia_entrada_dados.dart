import 'dart:io';

void main() {
  // Solicitar o nome do produto
  stdout.write('Digite o nome do produto: ');

  // Lê a entrada do usuário. O valor pode ser nulo (caso o usuário não digite nada).
  String? nomeProduto = stdin.readLineSync();

  // Usamos o operador de coalescência nula '??' para fornecer um valor padrão 'Produto não informado'
  // Caso o usuário não forneça um nome (se 'nomeProduto' for null), ele será substituído por 'Produto não informado'.
  nomeProduto = nomeProduto ?? 'Produto não informado';

  // Solicitar o preço do produto
  stdout.write('Digite o preço do produto: ');

  // Lê a entrada do usuário para o preço. Pode ser nula, caso o usuário não digite nada.
  String? precoProduto = stdin.readLineSync();

  // Tenta converter o preço do produto para um valor numérico (double)
  // Se a conversão falhar (por exemplo, o usuário digitar texto), o operador '??' fornece o valor padrão 0.0.
  double preco = double.tryParse(precoProduto ?? '') ?? 0.0;

  // Exibe os dados do produto
  print('\nCadastro do Produto:');
  print('Nome do Produto: $nomeProduto');
  print('Preço do Produto: \$${preco.toStringAsFixed(2)}');
}
