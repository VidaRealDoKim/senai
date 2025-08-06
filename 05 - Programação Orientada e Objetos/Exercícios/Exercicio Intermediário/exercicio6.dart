import 'dart:io';

// Classe Retangulo representa um retângulo com largura e altura
class Retangulo {
  double _largura; // atributo privado para largura
  double _altura;  // atributo privado para altura

  // Construtor que recebe largura e altura
  // Usa assert para garantir que valores não sejam negativos na criação do objeto
  Retangulo(double largura, double altura)
      : assert(largura >= 0, 'Largura não pode ser negativa'),
        assert(altura >= 0, 'Altura não pode ser negativa'),
        _largura = largura,
        _altura = altura;

  // Getter para largura
  double get largura => _largura;

  // Setter para largura com validação
  set largura(double value) {
    if (value >= 0) {
      _largura = value;
    } else {
      print('Largura inválida. Deve ser maior ou igual a zero.');
    }
  }

  // Getter para altura
  double get altura => _altura;

  // Setter para altura com validação
  set altura(double value) {
    if (value >= 0) {
      _altura = value;
    } else {
      print('Altura inválida. Deve ser maior ou igual a zero.');
    }
  }

  // Método que calcula a área do retângulo (largura * altura)
  double area() => _largura * _altura;

  // Método que calcula o perímetro do retângulo (2 * (largura + altura))
  double perimetro() => 2 * (_largura + _altura);
}

// Função principal do exercício que roda o programa
void executarExercicio6() {
  try {
    // Solicita a largura do retângulo ao usuário
    stdout.write('Digite a largura do retângulo: ');
    double largura = double.parse(stdin.readLineSync()!);

    // Solicita a altura do retângulo ao usuário
    stdout.write('Digite a altura do retângulo: ');
    double altura = double.parse(stdin.readLineSync()!);

    // Cria um objeto Retangulo com os valores fornecidos
    Retangulo retangulo = Retangulo(largura, altura);

    // Exibe a área calculada
    print('Área: ${retangulo.area()}');

    // Exibe o perímetro calculado
    print('Perímetro: ${retangulo.perimetro()}');
  } catch (e) {
    // Captura qualquer erro, como entrada inválida, e exibe mensagem
    print('Erro: ${e}');
  }
}
