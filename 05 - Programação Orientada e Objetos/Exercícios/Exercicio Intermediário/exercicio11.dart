import 'dart:io';

// Classe Produto representa um item com nome e preço
class Produto {
  String nome;
  double preco;

  Produto(this.nome, this.preco);
}

// Classe Carrinho gerencia uma lista de produtos e operações relacionadas
class Carrinho {
  List<Produto> produtos = [];

  // Adiciona um produto na lista e avisa o usuário
  void adicionarProduto(Produto produto) {
    produtos.add(produto);
    print("Produto '${produto.nome}' adicionado ao carrinho.");
  }

  // Remove produto pelo nome (ignorando maiúsculas/minúsculas)
  // Verifica se algum produto foi removido e avisa o usuário
  void removerProduto(String nomeProduto) {
    int countAntes = produtos.length;
    produtos.removeWhere((p) => p.nome.toLowerCase() == nomeProduto.toLowerCase());
    int countDepois = produtos.length;

    if (countDepois < countAntes) {
      print("Produto '$nomeProduto' removido do carrinho.");
    } else {
      print("Produto '$nomeProduto' não encontrado no carrinho.");
    }
  }

  // Lista todos os produtos com seus preços formatados
  // Se a lista estiver vazia, avisa que o carrinho está vazio
  void listarProdutos() {
    if (produtos.isEmpty) {
      print("O carrinho está vazio.");
      return;
    }
    print("Produtos no carrinho:");
    for (var produto in produtos) {
      print("- ${produto.nome}: R\$ ${produto.preco.toStringAsFixed(2)}");
    }
  }

  // Calcula o total somando os preços de todos os produtos
  double calcularTotal() {
    return produtos.fold(0, (total, produto) => total + produto.preco);
  }
}

// Função para ler e validar o preço do produto
// Garante que seja um número válido maior que zero
double lerPrecoValido() {
  while (true) {
    stdout.write("Preço do produto: ");
    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print("Entrada inválida, tente novamente.");
      continue;
    }

    // Substitui vírgula por ponto para aceitar entrada comum no Brasil
    double? preco = double.tryParse(entrada.replaceAll(',', '.'));

    if (preco == null) {
      print("Erro: digite um número válido.");
      continue;
    }

    if (preco <= 0) {
      print("Erro: o preço deve ser maior que zero.");
      continue;
    }

    return preco;
  }
}

// Função para ler e validar o nome do produto
// Garante que não seja vazio ou nulo
String lerNomeProduto() {
  while (true) {
    stdout.write("Nome do produto: ");
    String? nome = stdin.readLineSync();

    if (nome == null || nome.trim().isEmpty) {
      print("Erro: nome do produto não pode ser vazio.");
      continue;
    }

    return nome.trim();
  }
}

// Função principal que executa o menu do carrinho e operações
void executarExercicio11() {
  Carrinho carrinho = Carrinho();

  while (true) {
    // Exibe o menu de opções para o usuário
    print("\n=== Menu do Carrinho ===");
    print("1 - Adicionar produto");
    print("2 - Remover produto");
    print("3 - Listar produtos");
    print("4 - Mostrar total");
    print("0 - Sair");
    stdout.write("Escolha uma opção: ");

    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
      // Solicita nome e preço e adiciona produto
        String nome = lerNomeProduto();
        double preco = lerPrecoValido();
        Produto produto = Produto(nome, preco);
        carrinho.adicionarProduto(produto);
        break;

      case '2':
      // Mostra produtos antes de pedir nome para remover
        print("\nProdutos no carrinho:");
        carrinho.listarProdutos();

        stdout.write("Nome do produto para remover: ");
        String nomeRemover = stdin.readLineSync() ?? '';
        carrinho.removerProduto(nomeRemover);
        break;

      case '3':
      // Lista todos os produtos no carrinho
        carrinho.listarProdutos();
        break;

      case '4':
      // Mostra o total dos preços formatado em reais
        print("Total do carrinho: R\$ ${carrinho.calcularTotal().toStringAsFixed(2)}");
        break;

      case '0':
      // Encerra o programa
        print("Encerrando o programa.");
        return;

      default:
        print("Opção inválida. Tente novamente.");
    }
  }
}
