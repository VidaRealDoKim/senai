import 'dart:io';

// Classe Pessoa com encapsulamento no atributo idade
class Pessoa {
  String nome;
  int _idade; // atributo privado (não acessível diretamente fora da classe)

  // Construtor com validação para idade não negativa
  Pessoa(this.nome, int idade) : _idade = (idade >= 0) ? idade : 0;

  // Getter para idade (permite acesso ao valor de _idade)
  int get idade => _idade;

  // Setter para idade com validação (não aceita idade negativa)
  set idade(int novaIdade) {
    if (novaIdade >= 0) {
      _idade = novaIdade;
    } else {
      print('Idade inválida. Não pode ser menor que zero.');
    }
  }

  // Método para exibir informações da pessoa formatadas
  void mostrarPessoa() {
    print('Nome: $nome, Idade: $_idade anos');
  }
}

// Função para ler idade válida do usuário via terminal
// Garante que a idade seja um número inteiro e não negativo
int lerIdadeValida(String mensagem) {
  while (true) {
    stdout.write(mensagem);
    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print('Entrada inválida. Tente novamente.');
      continue; // volta ao início do loop para nova tentativa
    }

    int? idade = int.tryParse(entrada);
    if (idade == null) {
      print('Erro: por favor, digite um número inteiro válido.');
      continue;
    }

    if (idade < 0) {
      print('Erro: a idade não pode ser negativa.');
      continue;
    }

    // Se tudo válido, retorna a idade
    return idade;
  }
}

// Função que executa o exercício 8: cria uma Pessoa e testa setter/getter
void executarExercicio8() {
  stdout.write('Digite o nome: ');
  String nome = stdin.readLineSync() ?? '';

  // Lê uma idade válida do usuário
  int idade = lerIdadeValida('Digite a idade: ');

  // Cria objeto Pessoa com nome e idade
  Pessoa pessoa = Pessoa(nome, idade);

  // Exibe dados da pessoa
  pessoa.mostrarPessoa();

  // Lê nova idade para testar o setter com validação
  int novaIdade = lerIdadeValida('Digite uma nova idade (para teste): ');
  pessoa.idade = novaIdade;

  // Exibe novamente após atualização
  pessoa.mostrarPessoa();
}
