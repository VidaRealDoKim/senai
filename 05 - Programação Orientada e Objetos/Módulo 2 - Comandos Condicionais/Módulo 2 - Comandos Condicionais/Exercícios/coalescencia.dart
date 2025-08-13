void main() {
  // Exemplo de um cadastro de usuários onde alguns campos podem ser nulos.

  // Simulando um banco de dados com algumas informações nulas:
  Map<String, String?> usuario1 = {
    'nome': 'Alice',
    'email': 'alice@example.com',
    'telefone': null, // O telefone de Alice não foi informado
    'endereco': null, // O endereço de Alice também não foi informado
  };

  Map<String, String?> usuario2 = {
    'nome': 'Bob',
    'email': null, // O email de Bob não foi informado
    'telefone': '987654321',
    'endereco': 'Rua X, 123',
  };

  // Vamos simular a exibição dos dados dos usuários
  print('Cadastro de Usuários:\n');

  // Para o usuario1, vamos usar o operador ?? para fornecer valores padrão
  print('Usuário 1:');
  String nome1 =
      usuario1['nome'] ??
      'Nome não informado'; // Se 'nome' for null, exibe 'Nome não informado'
  String email1 =
      usuario1['email'] ??
      'Email não informado'; // Se 'email' for null, exibe 'Email não informado'
  String telefone1 =
      usuario1['telefone'] ??
      'Telefone não informado'; // Se 'telefone' for null, exibe 'Telefone não informado'
  String endereco1 =
      usuario1['endereco'] ??
      'Endereço não informado'; // Se 'endereco' for null, exibe 'Endereço não informado'

  // Exibindo as informações do usuário1
  print('Nome: $nome1');
  print('Email: $email1');
  print('Telefone: $telefone1');
  print('Endereço: $endereco1');
  print(''); // Linha em branco para separar os usuários

  // Agora, para o usuario2, também usamos o operador ??
  print('Usuário 2:');
  String nome2 =
      usuario2['nome'] ??
      'Nome não informado'; // Se 'nome' for null, exibe 'Nome não informado'
  String email2 =
      usuario2['email'] ??
      'Email não informado'; // Se 'email' for null, exibe 'Email não informado'
  String telefone2 =
      usuario2['telefone'] ??
      'Telefone não informado'; // Se 'telefone' for null, exibe 'Telefone não informado'
  String endereco2 =
      usuario2['endereco'] ??
      'Endereço não informado'; // Se 'endereco' for null, exibe 'Endereço não informado'

  // Exibindo as informações do usuário2
  print('Nome: $nome2');
  print('Email: $email2');
  print('Telefone: $telefone2');
  print('Endereço: $endereco2');
}
