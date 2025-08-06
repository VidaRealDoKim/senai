import 'dart:io';

// Classe Animal que armazena nome e som do animal
class Animal {
  String nome;
  String som;

  Animal(this.nome, this.som);

  // Retorna o som do animal
  String fazerSom() {
    return som;
  }
}

// Função principal do exercício
void executarExercicio5() {
  print('Cadastro de animais');

  // Lista para armazenar os animais criados
  List<Animal> animais = [];

  while (true) {
    print('\n1 - Cadastrar novo animal');
    print('2 - Ouvir som de um animal');
    print('0 - Sair');
    stdout.write('Escolha uma opção: ');
    String? opcao = stdin.readLineSync();

    if (opcao == '1') {
      stdout.write('Digite o nome do animal: ');
      String nome = stdin.readLineSync()?.trim() ?? '';

      if (nome.isEmpty) {
        print('Nome inválido, tente novamente.');
        continue;
      }

      stdout.write('Digite o som que o animal faz: ');
      String som = stdin.readLineSync()?.trim() ?? '';

      if (som.isEmpty) {
        print('Som inválido, tente novamente.');
        continue;
      }

      animais.add(Animal(nome, som));
      print('Animal "$nome" com som "$som" cadastrado com sucesso!');
    } else if (opcao == '2') {
      if (animais.isEmpty) {
        print('Nenhum animal cadastrado ainda.');
        continue;
      }

      print('Animais cadastrados:');
      for (int i = 0; i < animais.length; i++) {
        print('${i + 1} - ${animais[i].nome}');
      }

      stdout.write('Escolha o número do animal para ouvir o som: ');
      int? escolha = int.tryParse(stdin.readLineSync() ?? '');

      if (escolha == null || escolha < 1 || escolha > animais.length) {
        print('Opção inválida.');
        continue;
      }

      Animal animalEscolhido = animais[escolha - 1];
      print('O som do ${animalEscolhido.nome} é: ${animalEscolhido.fazerSom()}');
    } else if (opcao == '0') {
      print('Encerrando programa...');
      break;
    } else {
      print('Opção inválida, tente novamente.');
    }
  }
}
