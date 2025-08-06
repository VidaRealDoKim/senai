import 'dart:io'; // Biblioteca para entrada e saída pelo terminal

// Define a classe ContaBancaria com os atributos titular, número e saldo
class ContaBancaria {
  String titular;   // Nome do titular da conta
  int numero;       // Número da conta bancária
  double saldo;     // Saldo atual da conta

  // Construtor que inicializa titular, número e saldo
  ContaBancaria(this.titular, this.numero, this.saldo);

  // Método para depositar valor na conta
  void depositar(double valor) {
    if (valor > 0) {  // Verifica se o valor é positivo
      saldo += valor; // Soma o valor ao saldo
      print('Depósito de R\$ ${valor.toStringAsFixed(2)} realizado com sucesso.');
    } else {
      print('Erro: Valor para depósito deve ser maior que zero.');
    }
  }

  // Método para sacar valor da conta
  void sacar(double valor) {
    if (valor <= 0) {
      print('Erro: Valor para saque deve ser maior que zero.');
    } else if (valor > saldo) { // Verifica saldo suficiente
      print('Erro: Saldo insuficiente para sacar R\$ ${valor.toStringAsFixed(2)}.');
    } else {
      saldo -= valor; // Deduz valor do saldo
      print('Saque de R\$ ${valor.toStringAsFixed(2)} realizado com sucesso.');
    }
  }

  // Método para mostrar o saldo atual formatado com 2 casas decimais
  void mostrarSaldo() {
    print('Saldo atual: R\$ ${saldo.toStringAsFixed(2)}');
  }
}

// Função para executar a interface do exercício 2 no terminal
Future<void> executarExercicio2() async {
  print('\n=== Exercício 2: Conta Bancária ===');

  // Entrada do nome do titular
  stdout.write('Nome do titular: ');
  String titular = stdin.readLineSync() ?? '';

  // Entrada do número da conta e conversão segura para int
  stdout.write('Número da conta: ');
  int numero = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  // Entrada do saldo inicial e conversão segura para double
  stdout.write('Saldo inicial: ');
  double saldo = double.tryParse(stdin.readLineSync() ?? '') ?? 0;

  // Cria uma instância da conta bancária com os dados informados
  var conta = ContaBancaria(titular, numero, saldo);

  // Loop para o menu interativo
  while (true) {
    print('\n1 - Depositar');
    print('2 - Sacar');
    print('3 - Ver saldo');
    print('0 - Voltar ao menu principal');
    stdout.write('Escolha uma opção: ');
    String? opcao = stdin.readLineSync();

    // Avalia a opção escolhida e executa a ação correspondente
    switch (opcao) {
      case '1': // Depósito
        stdout.write('Valor para depositar: ');
        double valor = double.tryParse(stdin.readLineSync() ?? '') ?? 0;
        conta.depositar(valor);
        break;
      case '2': // Saque
        stdout.write('Valor para sacar: ');
        double valor = double.tryParse(stdin.readLineSync() ?? '') ?? 0;
        conta.sacar(valor);
        break;
      case '3': // Mostrar saldo
        conta.mostrarSaldo();
        break;
      case '0': // Sair do loop e retornar para menu principal
        return;
      default:
        print('Opção inválida.');
    }
  }
}
