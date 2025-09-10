import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  Image,
  KeyboardAvoidingView,
  Platform,
  Pressable,
  Alert,
  SafeAreaView,
} from 'react-native';

// React Navigation
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

// Telas
import Dashboard from './Dashboard';
import Registro from './Registro';
import RedefinirSenha from './RedefinirSenha';

// Estilos
import { styles } from './styles';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Login">
        {/* Tela de Login */}
        <Stack.Screen
          name="Login"
          component={LoginScreen}
          options={{ headerShown: false }}
        />
        {/* Tela de Dashboard */}
        <Stack.Screen
          name="Dashboard"
          component={Dashboard}
          options={{ headerShown: false }}
        />
        {/* Tela de Registro */}
        <Stack.Screen
          name="Registro"
          component={Registro}
          options={{ headerShown: false }}
        />
        {/* Tela de Redefinir Senha */}
        <Stack.Screen
          name="RedefinirSenha"
          component={RedefinirSenha}
          options={{ headerShown: false }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

// -------------------- LOGIN --------------------
function LoginScreen({ navigation }) {
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');

  // Limpa a mensagem de erro após 3 segundos
  useEffect(() => {
    if (error) {
      const timer = setTimeout(() => setError(''), 3000);
      return () => clearTimeout(timer);
    }
  }, [error]);

  const handleLogin = () => {
    if (!email.includes('@')) {
      setError('Por favor, insira um e-mail válido!');
      return;
    }
    if (!senha) {
      setError('Por favor, insira sua senha!');
      return;
    }

    if (email === 'admin@burguerking.com' && senha === 'hamburguer') {
      setError('');
      navigation.replace('Dashboard');
    } else {
      setError('Usuário ou senha incorretos!');
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <KeyboardAvoidingView
        style={{ flex: 1, alignItems: 'center', justifyContent: 'center', width: '100%' }}
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      >
        {error ? <Text style={styles.errorText}>{error}</Text> : null}

        <Image
          source={{ uri: 'https://play-lh.googleusercontent.com/ZrVintO0bkm5Vn_iKIT7AR_78M1KcrwHPFSQGAiybeqBhyr1FqHm95Q8-72JNkkygw=w480-h960-rw' }}
          style={styles.logo}
        />

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

        <TouchableOpacity
          style={[styles.button, (!email || !senha) && styles.buttonDisabled]}
          onPress={handleLogin}
          disabled={!email || !senha}
        >
          <Text style={styles.buttonText}>ENTRAR</Text>
        </TouchableOpacity>

        <View style={styles.links}>
          <Pressable onPress={() => navigation.navigate('Registro')}>
            <Text style={styles.linkText}>Registrar-se</Text>
          </Pressable>
          <Pressable onPress={() => navigation.navigate('RedefinirSenha')}>
            <Text style={styles.linkText}>Redefinir a Senha</Text>
          </Pressable>
        </View>
      </KeyboardAvoidingView>

      <View style={{ position: 'absolute', bottom: 32, width: '100%', alignItems: 'center' }}>
        <Text style={{ color: '#3b5998', fontSize: 14 }}>Login: admin@burguerking.com</Text>
        <Text style={{ color: '#3b5998', fontSize: 14 }}>Senha: hamburguer</Text>
      </View>
    </SafeAreaView>
  );
}
