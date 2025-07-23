import 'dart:io';

void exercicio2() {
  int? idade;

  // Repetição até que o usuário digite uma idade válida e positiva
  while (true) {
    stdout.write('Digite sua idade: ');
    String? entrada = stdin.readLineSync();

    // Tenta converter para inteiro
    idade = int.tryParse(entrada ?? '');

    // Verifica se é um número válido e positivo
    if (idade == null || idade <= 0) {
      print('Erro: Por favor, digite uma idade válida e positiva.');
    } else {
      break; // Sai do loop se a idade for válida
    }
  }

  // Verifica se o acesso é permitido ou negado
  if (idade < 18) {
    print('Acesso negado');
  } else {
    print('Acesso permitido');
  }
}
