import 'dart:io';

void exercicio5() {
  stdout.write('Digite uma frase: ');
  String? frase = stdin.readLineSync();

  if (frase == null || frase.isEmpty) {
    print('Frase inválida!');
    return;
  }

  String texto = frase.toLowerCase();

  int vogais = 0;
  int consoantes = 0;
  int numeros = 0;

  const String vogaisStr = 'aeiou';
  final RegExp letraRegExp = RegExp(r'[a-z]');
  final RegExp numeroRegExp = RegExp(r'[0-9]');

  for (int i = 0; i < texto.length; i++) {
    String c = texto[i];

    if (letraRegExp.hasMatch(c)) {
      if (vogaisStr.contains(c)) {
        vogais++;
      } else {
        consoantes++;
      }
    } else if (numeroRegExp.hasMatch(c)) {
      numeros++;
    }
  }

  print('Número de vogais: $vogais');
  print('Número de consoantes: $consoantes');
  print('Número de números: $numeros');
}
