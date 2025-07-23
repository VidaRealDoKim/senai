import 'dart:io';

void exercicio4() {
  stdout.write('Digite o número de disciplinas: ');
  int? numDisciplinas = int.tryParse(stdin.readLineSync() ?? '');

  if (numDisciplinas == null || numDisciplinas <= 0) {
    print('Número de disciplinas inválido. O programa será encerrado.');
    return;
  }

  List<double> notas = [];

  print('Informe as notas das disciplinas (de 0 a 10):');

  for (int i = 1; i <= numDisciplinas; i++) {
    double? nota;

    do {
      stdout.write('Disciplina $i: ');
      String? entrada = stdin.readLineSync();

      nota = double.tryParse(entrada ?? '');

      if (nota == null || nota < 0 || nota > 10) {
        print('Nota inválida! Digite um número entre 0 e 10.');
        continue; // volta para pedir a nota novamente
      }
    } while (nota == null);

    notas.add(nota);
  }

  double media = notas.reduce((a, b) => a + b) / notas.length;

  print('\nNotas informadas: ${notas.map((n) => n.toStringAsFixed(1)).join(', ')}');
  print('Média final: ${media.toStringAsFixed(2)}');

  if (media >= 7.0) {
    print('Aluno aprovado!');
  } else if (media >= 5.0) {
    print('Aluno em recuperação.');
  } else {
    print('Aluno reprovado.');
  }
}
