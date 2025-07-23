import 'dart:io';

void exercicio1() {
  bool continuar = true;

  while (continuar) {
    // Solicita os dois números inteiros
    stdout.write('Digite o primeiro número inteiro: ');
    int? num1 = int.tryParse(stdin.readLineSync()!);

    stdout.write('Digite o segundo número inteiro: ');
    int? num2 = int.tryParse(stdin.readLineSync()!);

    // Verifica se a entrada foi válida
    if (num1 == null || num2 == null) {
      print('Erro: Você deve digitar números inteiros válidos.');
    } else {
      // Solicita a operação desejada
      stdout.write('Digite a operação desejada (+, -, *, /): ');
      String operacao = stdin.readLineSync()!;

      // Executa a operação com base na entrada do usuário
      switch (operacao) {
        case '+':
          print('Resultado: ${num1 + num2}');
          break;
        case '-':
          print('Resultado: ${num1 - num2}');
          break;
        case '*':
          print('Resultado: ${num1 * num2}');
          break;
        case '/':
          if (num2 == 0) {
            print('Erro: Divisão por zero não é permitida.');
          } else {
            print('Resultado: ${num1 / num2}');
          }
          break;
        default:
          print('Erro: Operação inválida. Use apenas +, -, * ou /.');
      }
    }

    // Pergunta se deseja continuar
    stdout.write('Deseja fazer outra operação? (s/n): ');
    String? resposta = stdin.readLineSync();

    if (resposta == null || resposta.toLowerCase() != 's') {
      continuar = false;
      print('Encerrando a calculadora. Até a próxima!');
    }
  }
}
