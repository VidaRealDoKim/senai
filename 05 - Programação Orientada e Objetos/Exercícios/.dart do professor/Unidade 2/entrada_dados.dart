import 'dart:io';

void main() {
  stdout.write("Qual é o seu nome? ");
  String? nome = stdin.readLineSync(); // ? indica que nome poderá ser nulo

  stdout.write("Quantos anos você tem? ");
  String? idadeInput = stdin.readLineSync();
  int idade = int.parse(idadeInput ?? '0'); // Converte String para int

  print("Olá, $nome! Você tem $idade anos.");
}
