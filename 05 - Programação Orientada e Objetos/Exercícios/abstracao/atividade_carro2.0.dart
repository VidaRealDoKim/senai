import 'dart:io';

void main() {
  List<Carro> carros = [];

  print('Quantos carros deseja criar?');
  int? quantidade = int.tryParse(stdin.readLineSync() ?? '');

  if (quantidade == null || quantidade <= 0) {
    print('Número inválido.');
    return;
  }

  for (int i = 0; i < quantidade; i++) {
    print('Carro ${i + 1}:');

    stdout.write('Ano: ');
    int? ano = int.tryParse(stdin.readLineSync() ?? '');
    if (ano == null) {
      print('Ano inválido, usando 0.');
      ano = 0;
    }

    stdout.write('Modelo: ');
    String modelo = stdin.readLineSync() ?? 'Modelo desconhecido';

    stdout.write('Marca: ');
    String marca = stdin.readLineSync() ?? 'Marca desconhecida';

    // Cria o objeto e adiciona na lista
    carros.add(Carro(ano, modelo, marca));
  }

  print('\nCarros cadastrados:');
  for (var carro in carros) {
    carro.mostrarDados();
  }
}

class Carro {
  int ano;
  String modelo;
  String marca;

  Carro(this.ano, this.modelo, this.marca);

  void mostrarDados() {
    print("Ano: $ano, Modelo: $modelo, Marca: $marca");
  }
}
