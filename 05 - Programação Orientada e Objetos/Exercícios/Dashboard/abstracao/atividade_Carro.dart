void main() {
  Carro carro1 = new Carro(2025, "Sedan", "Ford-Ka");
  // chama o método para mostrar os dados
  carro1.mostrarDados();
}

class Carro {
  int ano;
  String modelo;
  String marca;

  // Construtor da classe carro
  Carro(this.ano, this.modelo, this.marca);

  // Mostra os dados do carro após a entrada de dados
  void mostrarDados() {
    print("Ano: $ano, Modelo: $modelo, Marca: $marca");
  }
}