import 'dart:io';

// Classe abstrata que define o contrato para pagamento
abstract class Pagamento {
  // Método abstrato que será implementado pelas subclasses
  void processarPagamento();
}

// Classe que implementa o pagamento via boleto
class PagamentoBoleto extends Pagamento {
  @override
  void processarPagamento() {
    print('Processando pagamento via boleto...');
  }
}

// Classe que implementa o pagamento via cartão
class PagamentoCartao extends Pagamento {
  @override
  void processarPagamento() {
    print('Processando pagamento via cartão...');
  }
}

// Função que executa o exercício 10
void executarExercicio10() {
  print('Escolha o método de pagamento:');
  print('1 - Boleto');
  print('2 - Cartão');
  stdout.write('Opção: ');
  String? opcao = stdin.readLineSync();

  // Variável do tipo abstrato Pagamento para armazenar a implementação escolhida
  Pagamento pagamento;

  // Escolhe a implementação concreta baseada na opção do usuário
  switch (opcao) {
    case '1':
      pagamento = PagamentoBoleto();
      break;
    case '2':
      pagamento = PagamentoCartao();
      break;
    default:
      print('Opção inválida. Encerrando.');
      return; // Sai da função se opção inválida
  }

  // Chama o método implementado da classe concreta
  pagamento.processarPagamento();
}
