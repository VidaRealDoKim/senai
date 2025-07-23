import 'dart:io';

// Importa os arquivos dos exercícios
import 'exercicio1.dart';
import 'exercicio2.dart';
import 'exercicio3.dart';
import 'exercicio4.dart';
import 'exercicio5.dart';
import 'exercicio6.dart';

void menu() {
  print('''
===== DASHBOARD DE EXERCÍCIOS =====
Escolha uma opção:
1 - Exercício 1: Calculadora Simples
2 - Exercício 2: Verificação de Idade e Acesso
3 - Exercício 3: Contagem Regressiva
4 - Exercício 4: Calculadora de Média e Situação do Aluno
5 - Exercício 5: Contador de Vogais e Consoantes
6 - Exercício 6: Jogo de Adivinhação
0 - Sair
''');
}

void main() {
  while (true) {
    menu();
    stdout.write('Digite a opção desejada: ');
    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        exercicio1();
        break;
      case '2':
        exercicio2();
        break;
      case '3':
        exercicio3();
        break;
      case '4':
        exercicio4();
        break;
      case '5':
        exercicio5();
        break;
      case '6':
        exercicio6();
        break;
      case '0':
        print('Saindo do programa. Até mais!');
        return;
      default:
        print('Opção inválida, tente novamente.');
    }

    print('\nPressione Enter para continuar...');
    stdin.readLineSync();
  }
}
