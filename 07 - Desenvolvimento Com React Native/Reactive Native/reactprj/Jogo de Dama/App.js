// App.js
import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ActivityIndicator,
  FlatList,
  StyleSheet,
  StatusBar,
} from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";

const Stack = createStackNavigator();

// ----------- Tela de Consulta -----------
function ConsultaScreen({ navigation }) {
  const [texto, setTexto] = useState("");
  const [loading, setLoading] = useState(false);
  const [dados, setDados] = useState(null);
  const [erro, setErro] = useState("");

  const buscarVersiculo = async () => {
    if (!texto.trim()) {
      setErro("Digite algo como 'John 3:16'");
      return;
    }
    try {
      setErro("");
      setLoading(true);
      const response = await fetch(`https://bible-api.com/${texto}`);
      const json = await response.json();

      if (json.error) {
        setErro("Versículo não encontrado!");
        setDados(null);
      } else {
        setDados(json);
      }
    } catch (e) {
      setErro("Erro ao buscar dados");
    } finally {
      setLoading(false);
    }
  };

  return (
    <View style={styles.container}>
      <StatusBar barStyle="light-content" backgroundColor="#111" />

      <Text style={styles.header}>📖 Bible Dashboard</Text>

      <TextInput
        style={styles.input}
        placeholder="Ex: John 3:16"
        placeholderTextColor="#aaa"
        value={texto}
        onChangeText={setTexto}
      />

      <TouchableOpacity style={styles.btn} onPress={buscarVersiculo}>
        <Text style={styles.btnText}>🔍 Buscar</Text>
      </TouchableOpacity>

      {loading && (
        <ActivityIndicator size="large" color="#FFD700" style={{ marginTop: 20 }} />
      )}

      {erro ? <Text style={styles.erro}>{erro}</Text> : null}

      {dados && (
        <TouchableOpacity
          style={styles.card}
          onPress={() => navigation.navigate("Detalhes", { versiculo: dados })}
        >
          <Text style={styles.referencia}>{dados.reference}</Text>
          <Text numberOfLines={2} style={styles.preview}>
            {dados.text}
          </Text>
        </TouchableOpacity>
      )}
    </View>
  );
}

// ----------- Tela de Detalhes -----------
function DetalhesScreen({ route }) {
  const { versiculo } = route.params;

  return (
    <View style={styles.container}>
      <Text style={styles.header}>{versiculo.reference}</Text>

      <FlatList
        data={versiculo.verses}
        keyExtractor={(item) => item.verse.toString()}
        renderItem={({ item }) => (
          <View style={styles.card}>
            <Text style={styles.referencia}>Verso {item.verse}</Text>
            <Text style={styles.texto}>{item.text}</Text>
          </View>
        )}
      />
    </View>
  );
}

// ----------- App Principal -----------
export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerStyle: { backgroundColor: "#111" },
          headerTintColor: "#FFD700",
          headerTitleStyle: { fontWeight: "bold" },
        }}
      >
        <Stack.Screen name="Consulta" component={ConsultaScreen} />
        <Stack.Screen name="Detalhes" component={DetalhesScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

// ----------- Estilos (Dashboard) -----------
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#1A1A1A",
    padding: 20,
  },
  header: {
    fontSize: 26,
    fontWeight: "bold",
    textAlign: "center",
    color: "#FFD700",
    marginBottom: 20,
  },
  input: {
    borderWidth: 1,
    borderColor: "#333",
    borderRadius: 12,
    padding: 12,
    backgroundColor: "#222",
    color: "#fff",
    marginBottom: 10,
    fontSize: 16,
  },
  btn: {
    backgroundColor: "#FFD700",
    padding: 15,
    borderRadius: 12,
    alignItems: "center",
    marginBottom: 20,
  },
  btnText: {
    fontWeight: "bold",
    fontSize: 16,
    color: "#111",
  },
  card: {
    backgroundColor: "#2A2A2A",
    borderRadius: 12,
    padding: 15,
    marginVertical: 8,
    shadowColor: "#000",
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 5,
  },
  referencia: {
    fontSize: 18,
    fontWeight: "bold",
    color: "#FFD700",
    marginBottom: 8,
  },
  preview: {
    fontSize: 15,
    color: "#ccc",
  },
  texto: {
    fontSize: 16,
    color: "#eee",
  },
  erro: {
    color: "red",
    marginTop: 10,
    textAlign: "center",
  },
});
