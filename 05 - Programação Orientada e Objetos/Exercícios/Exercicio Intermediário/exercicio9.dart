import 'dart:io';

// Definição da interface Imprimivel
// Uma interface define um contrato que as classes devem seguir
abstract class Imprimivel {
  // Método que todas as classes que implementam essa interface devem ter
  void imprimir();
}

// Classe Documento que implementa a interface Imprimivel
class Documento implements Imprimivel {
  String conteudo; // Conteúdo do documento

  // Construtor que recebe o conteúdo do documento
  Documento(this.conteudo);

  // Implementação do método imprimir da interface
  @override
  void imprimir() {
    print('Documento: $conteudo');
  }
}

// Classe Relatorio que implementa a interface Imprimivel
class Relatorio implements Imprimivel {
  String resumo; // Resumo do relatório

  // Construtor que recebe o resumo
  Relatorio(this.resumo);

  // Implementação do método imprimir da interface
  @override
  void imprimir() {
    print('Relatório: $resumo');
  }
}

// Função principal que executa o exercício 9
void executarExercicio9() {
  // Solicita o conteúdo do documento
  stdout.write('Digite o conteúdo do documento: ');
  String? conteudo = stdin.readLineSync();

  // Validação para não aceitar conteúdo vazio ou nulo
  if (conteudo == null || conteudo.isEmpty) {
    print('Conteúdo do documento não pode ser vazio.');
    return; // Encerra a função se inválido
  }

  // Solicita o resumo do relatório
  stdout.write('Digite o resumo do relatório: ');
  String? resumo = stdin.readLineSync();

  // Validação para não aceitar resumo vazio ou nulo
  if (resumo == null || resumo.isEmpty) {
    print('Resumo do relatório não pode ser vazio.');
    return; // Encerra a função se inválido
  }

  // Cria instâncias das classes que implementam Imprimivel
  Imprimivel documento = Documento(conteudo);
  Imprimivel relatorio = Relatorio(resumo);

  print('\nSaída da impressão:');

  // Chama o método imprimir das duas instâncias
  documento.imprimir();
  relatorio.imprimir();
}
