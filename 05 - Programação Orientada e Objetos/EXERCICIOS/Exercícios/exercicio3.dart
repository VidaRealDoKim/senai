import 'dart:io';

void exercicio3() {
  stdout.write('Digite um número inteiro positivo para a contagem regressiva: ');
  int? numInput = int.tryParse(stdin.readLineSync() ?? '');

  if (numInput == null || numInput <= 0) {
    print('Número inválido. O programa será encerrado.');
    return;
  }

  int num = numInput;

  while (num >= 0) {
    print('Faltam $num segundos para bomba explodir');
    sleep(Duration(seconds: 1)); // Pausa de 1 segundo
    num--;
  }

  print('BOOM!');
}
