import 'dart:io';

// Classe Livro representa um livro com título e autor
class Livro {
  String titulo;
  String autor;

  // Construtor para inicializar título e autor
  Livro(this.titulo, this.autor);
}

// Classe Usuario representa um usuário da biblioteca
class Usuario {
  String nome;

  // Construtor para inicializar nome do usuário
  Usuario(this.nome);
}

// Classe Emprestimo representa um empréstimo de livro feito por um usuário
class Emprestimo {
  Livro livro;      // Livro emprestado
  Usuario usuario;  // Usuário que fez o empréstimo
  DateTime data;    // Data do empréstimo

  // Construtor para inicializar livro, usuário e data
  Emprestimo(this.livro, this.usuario, this.data);

  // Método para exibir informações do empréstimo formatadas
  void exibirEmprestimo() {
    print(
        'Usuário: ${usuario.nome} | Livro: "${livro.titulo}" de ${livro.autor} | Data: ${data.toLocal()}');
  }
}

// Função que executa o exercício 7: registra um empréstimo via entrada do usuário
void executarExercicio7() {
  // Solicita nome do usuário que fará o empréstimo
  stdout.write('Nome do usuário: ');
  String nomeUsuario = stdin.readLineSync()!;

  // Solicita título do livro emprestado
  stdout.write('Título do livro: ');
  String tituloLivro = stdin.readLineSync()!;

  // Solicita autor do livro
  stdout.write('Autor do livro: ');
  String autorLivro = stdin.readLineSync()!;

  // Cria instâncias de Usuario e Livro com os dados fornecidos
  Usuario usuario = Usuario(nomeUsuario);
  Livro livro = Livro(tituloLivro, autorLivro);

  // Cria um objeto Emprestimo, com a data atual (DateTime.now())
  Emprestimo emprestimo = Emprestimo(livro, usuario, DateTime.now());

  // Exibe mensagem e detalhes do empréstimo registrado
  print('\n=== Empréstimo Registrado ===');
  emprestimo.exibirEmprestimo();
}
