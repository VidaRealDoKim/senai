import { StyleSheet } from 'react-native';

export const styles = StyleSheet.create({
  // Container principal para Login e Dashboard
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
    backgroundColor: '#f6ecda', // Fundo amarelo estilo Burger King
  },
  // Logo
  logo: {
    width: 120,
    height: 120,
    marginBottom: 40,
    borderRadius: 60,
    backgroundColor: '#fff',
  },
  // Container dos inputs
  inputContainer: {
    width: '100%',
    marginBottom: 20,
  },
  // Campos de texto (e-mail e senha)
  input: {
    backgroundColor: '#fff',
    paddingVertical: 12,
    paddingHorizontal: 20,
    borderRadius: 30,
    marginBottom: 15,
  },
  // Botão de login
  button: {
    backgroundColor: '#E4002B',
    paddingVertical: 15,
    paddingHorizontal: 100,
    borderRadius: 30,
    alignItems: 'center',
    marginBottom: 20,
  },
  buttonDisabled: {
    backgroundColor: '#A0A0A0',
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 18,
  },
  // Links "Registrar-se" e "Redefinir a senha"
  links: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    width: '80%',
  },
  linkText: {
    color: '#E4002B',
    fontWeight: 'bold',
    fontSize: 14,
  },
  // Mensagem de erro
  errorText: {
    color: '#E4002B',
    fontWeight: 'bold',
    marginBottom: 10,
    fontSize: 16,
    textAlign: 'center',
  },
  // Dashboard
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#E4002B',
    marginBottom: 10,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 16,
    color: '#333',
    marginBottom: 40,
    textAlign: 'center',
  },
  // Card do burger
  card: {
    backgroundColor: '#fff',
    borderRadius: 20,
    marginBottom: 20,
    alignItems: 'center',
    padding: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 3,
  },
  cardImage: {
    width: 180,
    height: 120,
    borderRadius: 15,
    resizeMode: 'contain',
    marginBottom: 10,
  },
  cardTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    textAlign: 'center',
    color: '#333',
  },

});
