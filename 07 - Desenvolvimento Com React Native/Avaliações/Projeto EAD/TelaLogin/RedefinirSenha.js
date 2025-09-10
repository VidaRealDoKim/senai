import React, { useState, useRef } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  Alert,
  SafeAreaView,
  KeyboardAvoidingView,
  Platform,
} from 'react-native';
import { styles } from './styles';

export default function RedefinirSenha({ navigation }) {
  const [email] = useState('admin@burguerking.com'); // Email fixo
  const [senha, setSenha] = useState('');
  const [confirmSenha, setConfirmSenha] = useState('');
  const senhaInput = useRef(null);

  const isFormValid = senha && confirmSenha;

  const handleSalvar = () => {
    if (senha !== confirmSenha) {
      Alert.alert('Erro', 'Senhas não são iguais', [
        { text: 'OK', onPress: () => senhaInput.current.focus() },
      ]);
      return;
    }

    Alert.alert('Sucesso', 'Senha redefinida com sucesso', [
      { text: 'OK', onPress: () => navigation.navigate('Login') },
    ]);
  };

  return (
    <SafeAreaView style={styles.container}>
      <KeyboardAvoidingView
        style={{ flex: 1, alignItems: 'center', justifyContent: 'center', width: '100%' }}
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      >
        <Text style={styles.title}>Redefinir Senha</Text>

        {/* Mostra o email do usuário */}
        <Text style={{ color: '#3b5998', fontSize: 14, marginBottom: 15 }}>{email}</Text>

        <View style={{ width: '100%', marginBottom: 20 }}>
          <TextInput
            ref={senhaInput}
            style={styles.input}
            placeholder="Senha"
            secureTextEntry
            value={senha}
            onChangeText={setSenha}
          />
          <TextInput
            style={styles.input}
            placeholder="Confirmar Senha"
            secureTextEntry
            value={confirmSenha}
            onChangeText={setConfirmSenha}
          />
        </View>

        <TouchableOpacity
          style={[styles.button, !isFormValid && styles.buttonDisabled]}
          onPress={handleSalvar}
          disabled={!isFormValid}
        >
          <Text style={styles.buttonText}>SALVAR</Text>
        </TouchableOpacity>

        <TouchableOpacity onPress={() => navigation.navigate('Login')} style={{ marginTop: 10 }}>
          <Text style={styles.linkText}>Voltar para Login</Text>
        </TouchableOpacity>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}
