import { StyleSheet } from 'react-native';

export const styles = StyleSheet.create({
  // Container principal usado em todas as telas (Login, Registro, Dashboard, etc)
  container: {
    flex: 1, // ocupa toda a tela
    alignItems: 'center', // centraliza horizontalmente
    justifyContent: 'center', // centraliza verticalmente
    padding: 20, // espaçamento interno
    backgroundColor: '#f6ecda', // cor de fundo (amarelo estilo Burger King)
  },

  // Logo do app
  logo: {
    width: 180,
    height: 180,
    marginBottom: 40, // distância embaixo da logo
    borderRadius: 60, // bordas arredondadas
    backgroundColor: '#fff', // fundo branco da logo
  },

  // Container que envolve os inputs (para alinhamento e espaçamento)
  inputContainer: {
    width: '100%', // ocupa toda a largura
    marginBottom: 20, // espaço abaixo dos inputs
  },

  // Estilo dos inputs (email, senha, CPF, nome)
  input: {
    backgroundColor: '#fff', // fundo branco
    paddingVertical: 15, // altura interna do input
    paddingHorizontal: 20, // espaçamento lateral
    borderRadius: 30, // borda arredondada
    marginBottom: 15, // espaço entre inputs
    fontSize: 16, // tamanho da fonte
  },

  // Botões principais (login, salvar, logout)
  button: {
    backgroundColor: '#E4002B', // vermelho Burger King
    paddingVertical: 15, // altura do botão
    borderRadius: 30, // borda arredondada
    alignItems: 'center', // centraliza texto horizontalmente
    marginBottom: 20, // espaço abaixo do botão
    width: '100%', // ocupa toda a largura
  },

  // Botão desabilitado (quando não preencheu campos obrigatórios)
  buttonDisabled: {
    backgroundColor: '#FF9933'
  },

  // Texto dentro dos botões
  buttonText: {
    color: '#fff', // branco
    fontWeight: 'bold', // negrito
    fontSize: 18, // tamanho da fonte
  },

  // Container para links "Registrar-se" e "Redefinir a senha"
  links: {
    flexDirection: 'row', // organiza os links na horizontal
    justifyContent: 'space-between', // espaço igual entre eles
    width: '80%', // largura dos links
    marginTop: 10, // distância do conteúdo acima
  },

  // Texto dos links
  linkText: {
    color: '#E4002B', // vermelho
    fontWeight: 'bold', // negrito
    fontSize: 14, // tamanho da fonte
  },

  // Texto de erro (ex: usuário ou senha incorretos)
  errorText: {
    color: '#E4002B', // vermelho
    fontWeight: 'bold', // negrito
    marginBottom: 10, // distância abaixo
    fontSize: 16, // tamanho da fonte
    textAlign: 'center', // centraliza horizontalmente
  },

  // Título principal (ex: Dashboard ou Cadastro)
  title: {
    fontSize: 24, // tamanho grande
    fontWeight: 'bold', // negrito
    color: '#E4002B', // vermelho
    marginBottom: 10, // espaço abaixo
    textAlign: 'center', // centralizado
  },

  // Subtítulo ou descrição menor
  subtitle: {
    fontSize: 16, // tamanho menor
    color: '#333', // cinza escuro
    marginBottom: 40, // espaço abaixo
    textAlign: 'center', // centralizado
  },

  // Card que contém cada hambúrguer no Dashboard
  card: {
    backgroundColor: '#fff', // fundo branco
    borderRadius: 20, // borda arredondada
    marginBottom: 20, // espaço entre cards
    alignItems: 'center', // centraliza conteúdo horizontalmente
    padding: 10, // espaçamento interno
    shadowColor: '#000', // sombra preta
    shadowOffset: { width: 0, height: 2 }, // deslocamento da sombra
    shadowOpacity: 0.2, // opacidade da sombra
    shadowRadius: 4, // raio da sombra
    elevation: 3, // sombra no Android
  },

  // Imagem dentro do card do hambúrguer
  cardImage: {
    width: 180, // largura da imagem
    height: 120, // altura da imagem
    borderRadius: 15, // borda arredondada
    resizeMode: 'contain', // mantém proporção da imagem
    marginBottom: 10, // distância do texto abaixo
  },

  // Nome do hambúrguer dentro do card
  cardTitle: {
    fontSize: 14, // tamanho da fonte
    fontWeight: 'bold', // negrito
    textAlign: 'center', // centralizado
    color: '#333', // cor cinza escura
  },
});
