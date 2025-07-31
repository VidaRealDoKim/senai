import 'dart:io';
import 'dart:math';

void exercicio6() {
  final random = Random();
  int numeroSecreto = random.nextInt(100) + 1;

  int tentativas = 0;
  int? palpite;

  print('Jogo de Adivinhação!');
  print('Tente adivinhar o número entre 1 e 100.');

  while (true) {
    stdout.write('Digite seu palpite: ');
    String? entrada = stdin.readLineSync();

    palpite = int.tryParse(entrada ?? '');

    if (palpite == null || palpite < 1 || palpite > 100) {
      print('Por favor, digite um número inteiro entre 1 e 100.');
      continue;
    }

    tentativas++;

    if (palpite == numeroSecreto) {
      print('Parabéns! Você acertou o número $numeroSecreto em $tentativas tentativas.');
      break;
    } else if (palpite < numeroSecreto) {
      print('Seu palpite está muito baixo.');
    } else {
      print('Seu palpite está muito alto.');
    }
  }

  print('Obrigado por jogar! 🎉');
}
