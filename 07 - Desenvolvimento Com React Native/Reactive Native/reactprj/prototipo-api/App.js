import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  Image,
  ActivityIndicator,
  TouchableOpacity,
  Linking,
  Alert
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient'; // Para gradiente de fundo
import { StatusBar } from 'expo-status-bar'; // Barra de status do dispositivo
import { Ionicons } from '@expo/vector-icons'; // Ícones para UI

// Dados de fallback caso a API falhe ou esteja lenta
const fallbackRockets = [
  {
    id: '1',
    name: 'Falcon 9',
    country: 'USA',
    description: 'Foguete reutilizável da SpaceX.',
    wikipedia: 'https://en.wikipedia.org/wiki/Falcon_9',
    flickr_images: ['https://live.staticflickr.com/65535/50012345678_abcdef.jpg']
  },
  {
    id: '2',
    name: 'Ariane 5',
    country: 'França',
    description: 'Foguete europeu de grande porte.',
    wikipedia: 'https://en.wikipedia.org/wiki/Ariane_5',
    flickr_images: ['https://live.staticflickr.com/65535/50098765432_abcdef.jpg']
  }
];

export default function App() {
  // Estado para armazenar a lista de foguetes
  const [rockets, setRockets] = useState([]);
  // Estado para controlar a tela de loading
  const [loading, setLoading] = useState(true);

  // useEffect executa quando o componente é montado
  useEffect(() => {
    // Faz requisição à API da SpaceX para obter foguetes
    fetch('https://api.spacexdata.com/v4/rockets')
      .then((res) => res.json()) // Converte a resposta em JSON
      .then((data) => {
        // Se a API retornar dados, usa eles; se não, usa o fallback
        setRockets(data.length ? data : fallbackRockets);
        setLoading(false); // Desativa a tela de loading
      })
      .catch((err) => {
        // Caso haja erro na API, loga no console e usa fallback
        console.log(err);
        setRockets(fallbackRockets);
        setLoading(false);
        Alert.alert('Erro', 'Não foi possível carregar dados da API. Usando fallback.');
      });
  }, []); // Array vazio [] garante que execute apenas uma vez

  // Tela de loading enquanto os dados são carregados
  if (loading) {
    return (
      <LinearGradient colors={['#0f0c29', '#302b63', '#24243e']} style={styles.container}>
        <ActivityIndicator size="large" color="#fff" /> {/* Spinner de carregamento */}
        <Text style={styles.loadingText}>Preparando o lançamento...</Text>
        <Ionicons name="rocket-outline" size={50} color="#fff" style={{ marginTop: 10 }} />
      </LinearGradient>
    );
  }

  // Função para renderizar cada foguete na lista
  const renderRocket = ({ item }) => (
    <TouchableOpacity
      style={styles.card}
      activeOpacity={0.8}
      onPress={() => Linking.openURL(item.wikipedia)} // Abre Wikipedia ao clicar
    >
      <Image source={{ uri: item.flickr_images[0] }} style={styles.image} /> {/* Imagem do foguete */}
      <View style={styles.cardInfo}>
        <Text style={styles.rocketName}>{item.name}</Text> {/* Nome do foguete */}
        <Text style={styles.desc}>{item.description.slice(0, 120)}...</Text> {/* Descrição resumida */}
        <View style={styles.cardFooter}>
          <Text style={styles.country}>{item.country}</Text> {/* País de origem */}
          <Ionicons name="rocket-outline" size={18} color="#fff" /> {/* Ícone pequeno */}
        </View>
      </View>
    </TouchableOpacity>
  );

  // Render principal do app
  return (
    <LinearGradient colors={['#0f0c29', '#302b63', '#24243e']} style={styles.container}>
      <StatusBar style="light" /> {/* Barra de status branca */}
      {/* Header com título e ícones */}
      <View style={styles.header}>
        <Ionicons name="planet-outline" size={26} color="#fff" />
        <Text style={styles.title}>Foguetes do Mundo</Text>
        <Ionicons name="planet-outline" size={26} color="#fff" />
      </View>
      {/* Lista de foguetes */}
      <FlatList
        data={rockets} // Dados da lista
        keyExtractor={(item) => item.id} // Chave única para cada item
        renderItem={renderRocket} // Função de renderização
        contentContainerStyle={{ paddingBottom: 50 }}
        showsVerticalScrollIndicator={false} // Esconde barra de rolagem
      />
    </LinearGradient>
  );
}

// Estilos do app
const styles = StyleSheet.create({
  container: { flex: 1, paddingTop: 50 },
  header: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 20,
    gap: 10
  },
  title: { color: '#fff', fontSize: 22, fontWeight: 'bold', letterSpacing: 2 },
  card: {
    backgroundColor: 'rgba(255,255,255,0.1)',
    borderRadius: 16,
    marginHorizontal: 16,
    marginVertical: 10,
    overflow: 'hidden',
    shadowColor: '#fff',
    shadowOpacity: 0.4,
    shadowRadius: 10
  },
  image: { width: '100%', height: 220 },
  cardInfo: { padding: 12 },
  rocketName: { color: '#fff', fontSize: 20, fontWeight: 'bold' },
  desc: { color: '#ccc', marginTop: 8, fontSize: 14 },
  cardFooter: {
    marginTop: 10,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center'
  },
  country: { color: '#fff', fontSize: 13, opacity: 0.7 },
  loadingText: { color: '#fff', marginTop: 10, fontSize: 16 }
});
