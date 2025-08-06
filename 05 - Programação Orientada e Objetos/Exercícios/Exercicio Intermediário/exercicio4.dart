import 'dart:io';

// Define uma classe abstrata Veiculo com métodos abstratos ligar e desligar
abstract class Veiculo {
  void ligar();
  void desligar();
}

// Classe Carro que herda Veiculo e implementa os métodos ligar e desligar
class Carro extends Veiculo {
  @override
  void ligar() {
    print('Carro ligado.');
  }

  @override
  void desligar() {
    print('Carro desligado.');
  }
}

// Classe Moto que herda Veiculo e implementa os métodos ligar e desligar
class Moto extends Veiculo {
  @override
  void ligar() {
    print('Moto ligada.');
  }

  @override
  void desligar() {
    print('Moto desligada.');
  }
}

// Função que executa o exercício 4
void executarExercicio4() {
  print('Escolha o veículo para operar:');
  print('1 - Carro');
  print('2 - Moto');
  stdout.write('Opção: ');
  String? opcao = stdin.readLineSync();

  Veiculo veiculo;

  // Seleciona a classe correta com base na opção do usuário
  switch (opcao) {
    case '1':
      veiculo = Carro();
      break;
    case '2':
      veiculo = Moto();
      break;
    default:
      print('Opção inválida.');
      return; // Sai da função se opção inválida
  }

  print('Operações disponíveis:');
  print('1 - Ligar');
  print('2 - Desligar');
  stdout.write('Escolha uma operação: ');
  String? operacao = stdin.readLineSync();

  // Executa o método correto baseado na operação escolhida
  switch (operacao) {
    case '1':
      veiculo.ligar();
      break;
    case '2':
      veiculo.desligar();
      break;
    default:
      print('Operação inválida.');
  }
}
