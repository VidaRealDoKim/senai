import React from 'react';
import { View, Text, TouchableOpacity, Image, FlatList } from 'react-native';
import { styles } from './styles';

// Dados dos hambúrgueres
const burgers = [
  {
    id: '1',
    name: 'Mega Stacker Rodeio 2.0',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/site_Mega_Stacker_Rodeio_2.0-1.png?mtime=20250120125654&focal=none',
  },
  {
    id: '2',
    name: 'Mega Stacker Rodeio 3.0',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/site_Mega_Stacker_Rodeio_3.0.png?mtime=20250120120301&focal=none',
  },
  {
    id: '3',
    name: 'Whopper Rodeio',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/Whopper-Rodeio.png?mtime=20230731152626&focal=none',
  },
  {
    id: '4',
    name: 'Whopper Furioso',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/Whopper-Furioso.png?mtime=20230731152817&focal=none',
  },
  {
    id: '5',
    name: 'Whopper Duplo',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/whopper-duplo-thumb.png?mtime=20210916101816&focal=none',
  },
  {
    id: '6',
    name: 'Mega Stacker Cheddar 2.0',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/maga-stacker-cheddar-2-thumb.png?mtime=20210916104008&focal=none',
  },
  {
    id: '7',
    name: 'Mega Stacker 2.0',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/maga-stacker-2-thumb.png?mtime=20210916103150&focal=none',
  },
];

export default function Dashboard({ navigation }) {

  // Função para logout
  const handleLogout = () => {
    navigation.replace('Login');
  };

  // Função para renderizar cada card do burger
  const renderItem = ({ item }) => (
    <View style={styles.card}>
      <Image source={{ uri: item.image }} style={styles.cardImage} />
      <Text style={styles.cardTitle}>{item.name}</Text>
    </View>
  );

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Bem-vindo ao Burger King!</Text>

      {/* Mini carrossel vertical */}
      <FlatList
        data={burgers}
        renderItem={renderItem}
        keyExtractor={(item) => item.id}
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ paddingBottom: 40 }}
      />

      {/* Botão de logout */}
      <TouchableOpacity
        style={[styles.button, { marginTop: 20 }]}
        onPress={handleLogout}
      >
        <Text style={styles.buttonText}>SAIR</Text>
      </TouchableOpacity>
    </View>
  );
}
