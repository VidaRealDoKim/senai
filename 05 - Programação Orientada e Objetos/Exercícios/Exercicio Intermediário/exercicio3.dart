import 'dart:io';

// Define uma classe abstrata Funcionario, que obriga a implementar calcularSalario()
abstract class Funcionario {
  double calcularSalario();
}

// Classe Desenvolvedor que estende Funcionario
// Salário calculado como valorHora * horasTrabalhadas
class Desenvolvedor extends Funcionario {
  double valorHora;         // Valor pago por hora
  int horasTrabalhadas;     // Quantidade de horas trabalhadas

  // Construtor com parâmetros nomeados obrigatórios
  Desenvolvedor({required this.valorHora, required this.horasTrabalhadas});

  // Implementa o método abstrato calcularSalario()
  @override
  double calcularSalario() => valorHora * horasTrabalhadas;
}

// Classe Gerente que estende Funcionario
// Salário calculado como salário fixo + bônus
class Gerente extends Funcionario {
  double salarioFixo;    // Salário fixo mensal
  double bonus;          // Bônus adicional

  // Construtor com parâmetros nomeados obrigatórios
  Gerente({required this.salarioFixo, required this.bonus});

  // Implementa o método abstrato calcularSalario()
  @override
  double calcularSalario() => salarioFixo + bonus;
}

// Função que executa o exercício 3 com interação via terminal
void executarExercicio3() {
  print('Escolha o tipo de funcionário:');
  print('1 - Desenvolvedor');
  print('2 - Gerente');
  stdout.write('Opção: ');
  String? opcao = stdin.readLineSync();

  if (opcao == '1') { // Se for Desenvolvedor
    stdout.write('Digite o valor da hora trabalhada: ');
    double valorHora = double.tryParse(stdin.readLineSync()!) ?? 0;

    stdout.write('Digite a quantidade de horas trabalhadas: ');
    int horas = int.tryParse(stdin.readLineSync()!) ?? 0;

    // Cria o objeto Desenvolvedor e calcula o salário
    Desenvolvedor dev = Desenvolvedor(valorHora: valorHora, horasTrabalhadas: horas);
    print('Salário do desenvolvedor: R\$ ${dev.calcularSalario().toStringAsFixed(2)}');

  } else if (opcao == '2') { // Se for Gerente
    stdout.write('Digite o salário fixo: ');
    double salarioFixo = double.tryParse(stdin.readLineSync()!) ?? 0;

    stdout.write('Digite o valor do bônus: ');
    double bonus = double.tryParse(stdin.readLineSync()!) ?? 0;

    // Cria o objeto Gerente e calcula o salário
    Gerente gerente = Gerente(salarioFixo: salarioFixo, bonus: bonus);
    print('Salário do gerente: R\$ ${gerente.calcularSalario().toStringAsFixed(2)}');

  } else { // Opção inválida
    print('Opção inválida.');
  }
}
