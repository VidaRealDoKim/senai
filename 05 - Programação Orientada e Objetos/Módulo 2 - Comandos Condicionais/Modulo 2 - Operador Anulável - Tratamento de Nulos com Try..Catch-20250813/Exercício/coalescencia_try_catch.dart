import 'dart:io';

void main() {
  // Simulando a entrada dos dados dos produtos

  // Solicitar o nome do produto
  stdout.write('Digite o nome do produto: ');

  // Lê a entrada do usuário. O valor pode ser nulo (caso o usuário não digite nada).
  String? nomeProduto = stdin.readLineSync();

  // Verifica se o nome é nulo ou vazio
  try {
    // Se 'nomeProduto' for null ou vazio, lançamos uma exceção
    if (nomeProduto == null || nomeProduto.isEmpty) {
      throw FormatException("Nome do produto não pode ser vazio.");
    }
  } catch (e) {
    // Se uma exceção ocorrer, fornecemos um valor padrão
    nomeProduto = 'Produto não informado';
    //    print(e); // Exibe a mensagem do erro no catch
    // Se uma exceção ocorrer, fornecemos um valor padrão e mostramos uma mensagem amigável
    print('Nome do produto não informado !!!');
  }

  // Solicitar o preço do produto
  stdout.write('Digite o preço do produto: ');

  // Lê a entrada do usuário para o preço. Pode ser nula, caso o usuário não digite nada.
  String? precoProduto = stdin.readLineSync();

  double preco = 0.0; // Inicializa a variável de preço

  try {
    // Tenta converter o preço para double
    preco = double.tryParse(precoProduto ?? '') ?? 0.0;
    if (preco == 0.0 && precoProduto != '0.0') {
      throw FormatException("Preço inválido");
    }
  } catch (e) {
    // Se a conversão falhar, o valor de 'preco' será 0.0 e mostramos uma mensagem de erro
    //    print(e); // Exibe a mensagem do erro no catch

    // Se a conversão falhar, fornecemos uma mensagem amigável sem expor a exceção
    print('Preço igual a ZERO ou não numérico !!! Verifique.');
  }

  // Exibe os dados do produto
  print('\nCadastro do Produto:');
  print('Nome do Produto: $nomeProduto');
  print('Preço do Produto: \$${preco.toStringAsFixed(2)}');
}
