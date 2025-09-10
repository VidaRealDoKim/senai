import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  Image,
  StyleSheet,
  Alert,
  Pressable,
  KeyboardAvoidingView,
  Platform,
} from 'react-native';

export default function App() {
  // Estados para email, senha e mensagem de erro
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');

  // Limpa a mensagem de erro automaticamente após 3 segundos
  useEffect(() => {
    if (error) {
      const timer = setTimeout(() => setError(''), 3000);
      return () => clearTimeout(timer);
    }
  }, [error]);

  // Função do botão "ENTRAR"
  const handleLogin = () => {
    // Validação mínima: e-mail precisa ter "@"
    if (!email.includes('@')) {
      setError('Por favor, insira um e-mail válido!');
      return;
    }

    // Validação mínima: senha preenchida
    if (!senha) {
      setError('Por favor, insira sua senha!');
      return;
    }

    // Login fixo
    if (email === 'admin@burguerking.com' && senha === 'hamburguer') {
      setError('');
      Alert.alert('Login realizado com sucesso!');
    } else {
      setError('Usuário ou senha incorretos!');
    }
  };

  // Funções dos links
  const handleRegister = () => Alert.alert("Tela de Registro em breve!");
  const handleForgotPassword = () => Alert.alert("Tela de redefinição de senha em breve!");

  return (
    <KeyboardAvoidingView
      style={styles.container}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
    >
      {/* Mensagem de erro no topo */}
      {error ? <Text style={styles.errorText}>{error}</Text> : null}

      {/* Logo do app */}
      <Image
        source={{uri: 'https://play-lh.googleusercontent.com/ZrVintO0bkm5Vn_iKIT7AR_78M1KcrwHPFSQGAiybeqBhyr1FqHm95Q8-72JNkkygw=w480-h960-rw'}}
        style={styles.logo}
      />

      {/* Campos de entrada */}
      <View style={styles.inputContainer}>
        <TextInput
          style={styles.input}
          placeholder="E-mail"
          keyboardType="email-address"
          value={email}
          onChangeText={setEmail}
        />
        <TextInput
          style={styles.input}
          placeholder="Senha"
          secureTextEntry
          value={senha}
          onChangeText={setSenha}
        />
      </View>

      {/* Botão de login */}
      <TouchableOpacity
        style={[styles.button, (!email || !senha) && styles.buttonDisabled]}
        onPress={handleLogin}
        disabled={!email || !senha}
      >
        <Text style={styles.buttonText}>ENTRAR</Text>
      </TouchableOpacity>

      {/* Links */}
      <View style={styles.links}>
        <Pressable onPress={handleRegister}>
          <Text style={styles.linkText}>Registrar-se</Text>
        </Pressable>
        <Pressable onPress={handleForgotPassword}>
          <Text style={styles.linkText}>Redefinir a Senha</Text>
        </Pressable>
      </View>
    </KeyboardAvoidingView>
  );
}

// Estilos dos componentes
const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
    backgroundColor: '#f6ecda', // Fundo amarelo estilo Burger King
  },
  errorText: {
    color: '#E4002B', // Vermelho para mensagem de erro
    fontWeight: 'bold',
    marginBottom: 10,
    fontSize: 16,
    textAlign: 'center',
  },
  logo: {
    width: 120,
    height: 120,
    marginBottom: 40,
    borderRadius: 60,
    backgroundColor: '#fff',
  },
  inputContainer: {
    width: '100%',
    marginBottom: 20,
  },
  input: {
    backgroundColor: '#fff',
    paddingVertical: 12,
    paddingHorizontal: 20,
    borderRadius: 30,
    marginBottom: 15,
  },
  button: {
    backgroundColor: '#E4002B', // Vermelho intenso
    paddingVertical: 15,
    paddingHorizontal: 100,
    borderRadius: 30,
    alignItems: 'center',
    marginBottom: 20,
  },
  buttonDisabled: {
    backgroundColor: '#A0A0A0', // Cinza quando desabilitado
  },
  buttonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 18,
  },
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
});
