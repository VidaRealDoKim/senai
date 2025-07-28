class Cliente {
  int idCliente;
  String nomeCliente;
  String cpfCliente;

  // Construtor da classe Cliente
  Cliente(this.idCliente, this.nomeCliente, this.cpfCliente);

  // Mostra os dados do cliente após a entrada de dados
  void mostrarDados() {
    print("Id: $idCliente, Nome: $nomeCliente, Cpf: $cpfCliente");
  }
}

void main() {
  Cliente cli1 = new Cliente(1000, "João de Souza", "111.222.333-44");
  //
}