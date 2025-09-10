// Importa React e hooks
import React, { useState } from 'react';

// Importa componentes do React Native
import {
  View,       // Container principal
  Text,       // Para exibir rótulos e mensagens
  TextInput,  // Campo de entrada de texto
  Button,     // Botão de ação
  Image,      // Para exibir imagem ou logo
  StyleSheet, // Para estilizar os componentes
  Alert,      // Para exibir alertas
  Pressable   // Para criar links clicáveis
} from 'react-native';

// Componente principal do App
export default function App() {
  // Estados para armazenar valores do e-mail e senha
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');

  // Função executada ao clicar no botão "ENTRAR"
  const handleLogin = () => {
    Alert.alert("Login realizado com sucesso!");
  };

  // Função executada ao clicar no link "Registrar-se"
  const handleRegister = () => {
    Alert.alert("Tela de Registro em breve!");
  };

  // Função executada ao clicar no link "Redefinir a Senha"
  const handleForgotPassword = () => {
    Alert.alert("Tela de redefinição de senha em breve!");
  };

  return (
    // Container principal da tela
    <View style={styles.container}>

      {/* Logo do aplicativo */}
      <Image
        source={{uri: "https://reactnative.dev/img/tiny_logo.png"}}
        style={styles.logo}
      />

      {/* Campo de entrada para e-mail */}
      <Text style={styles.label}>E-mail</Text>
      <TextInput
        style={styles.input}
        placeholder="Digite seu e-mail"
        keyboardType="email-address" // Define tipo de teclado específico para e-mail
        value={email}                 // Valor atual do estado
        onChangeText={setEmail}       // Atualiza o estado ao digitar
      />

      {/* Campo de entrada para senha */}
      <Text style={styles.label}>Senha</Text>
      <TextInput
        style={styles.input}
        placeholder="Digite sua senha"
        secureTextEntry               // Esconde os caracteres digitados
        value={senha}                 // Valor atual do estado
        onChangeText={setSenha}       // Atualiza o estado ao digitar
      />

      {/* Botão de login */}
      <Button
        title="ENTRAR"
        onPress={handleLogin}         // Chama função de login
        disabled={!email || !senha}   // Habilita somente se ambos os campos estiverem preenchidos
      />

      {/* Links de "Registrar-se" e "Redefinir a Senha" */}
      <View style={styles.links}>
        <Pressable onPress={handleRegister}>
          <Text style={styles.linkText}>Registrar-se</Text>
        </Pressable>
        <Pressable onPress={handleForgotPassword}>
          <Text style={styles.linkText}>Redefinir a Senha</Text>
        </Pressable>
      </View>
    </View>
  );
}

// Estilos da tela
const styles = StyleSheet.create({
  container: {
    flex: 1,                 // Ocupa toda a tela
    justifyContent: 'center', // Centraliza verticalmente
    alignItems: 'center',    // Centraliza horizontalmente
    padding: 20,             // Espaçamento interno
    backgroundColor: '#f2f2f2', // Cor de fundo clara
  },
  logo: {
    width: 80,        // Largura do logo
    height: 80,       // Altura do logo
    marginBottom: 30, // Espaço abaixo do logo
  },
  label: {
    alignSelf: 'flex-start', // Alinha à esquerda
    fontSize: 16,
    fontWeight: 'bold',
    marginTop: 10,
  },
  input: {
    width: '100%',        // Campo ocupa toda largura do container
    borderWidth: 1,       // Largura da borda
    borderColor: '#aaa',  // Cor da borda
    borderRadius: 8,      // Cantos arredondados
    padding: 10,          // Espaçamento interno
    marginBottom: 10,     // Espaço abaixo do campo
    backgroundColor: '#fff', // Fundo branco
  },
  links: {
    marginTop: 20,        // Espaço acima dos links
    alignItems: 'center', // Centraliza horizontalmente
  },
  linkText: {
    color: '#0066cc',     // Cor azul para links
    marginTop: 10,        // Espaço entre os links
    fontSize: 16,
  },
});
