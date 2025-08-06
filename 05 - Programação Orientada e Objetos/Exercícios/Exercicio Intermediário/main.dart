import 'dart:io';

// Importa os arquivos dos exercícios
import 'exercicio1.dart';
import 'exercicio2.dart';
import 'exercicio3.dart';
import 'exercicio4.dart';
import 'exercicio5.dart';
import 'exercicio6.dart';
import 'exercicio7.dart';
import 'exercicio8.dart';
import 'exercicio9.dart';
import 'exercicio10.dart';
import 'exercicio11.dart';

void main() {
  List<String> titulos = [
    '1. Classe Produto',
    '2. Classe ContaBancaria',
    '3. Classe abstrata Funcionario',
    '4. Sistema de Veículos',
    '5. Herança e Polimorfismo com Animais',
    '6. Classe Retângulo',
    '7. Sistema de Biblioteca',
    '8. Classe Pessoa com Encapsulamento',
    '9. Interface Imprimivel',
    '10. Sistema de Pagamentos',
    '11. Classe Carrinho de Compras',
  ];

  while (true) {
    print('\n=== DASHBOARD DE EXERCÍCIOS ===');
    print('Escolha um exercício para executar:');
    for (var titulo in titulos) {
      print(titulo);
    }
    print('0. Sair');

    stdout.write('Opção: ');
    String? escolha = stdin.readLineSync();

    switch (escolha) {
      case '1':
        executarExercicio1();
        break;
      case '2':
        executarExercicio2();
        break;
      case '3':
        executarExercicio3();
        break;
      case '4':
        executarExercicio4();
        break;
      case '5':
        executarExercicio5();
        break;
      case '6':
        executarExercicio6();
        break;
      case '7':
        executarExercicio7();
        break;
      case '8':
        executarExercicio8();
        break;
      case '9':
        executarExercicio9();
        break;
      case '10':
        executarExercicio10();
        break;
      case '11':
        executarExercicio11();
        break;
      case '0':
        print('Encerrando...');
        return;
      default:
        print('Opção inválida, tente novamente.');
    }
  }
}
