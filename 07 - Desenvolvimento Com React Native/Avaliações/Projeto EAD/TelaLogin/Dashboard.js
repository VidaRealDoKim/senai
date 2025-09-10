import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  Image,
  FlatList,
  Modal,
  SafeAreaView,
} from 'react-native';
import { styles } from './styles';

// Dados dos hambúrgueres
const burgers = [
  {
    id: '1',
    name: 'Mega Stacker Rodeio 2.0',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/site_Mega_Stacker_Rodeio_2.0-1.png?mtime=20250120125654&focal=none',
    price: 'R$ 35,00',
    weight: '350g',
    kcal: '780 kcal',
  },
  {
    id: '2',
    name: 'Mega Stacker Rodeio 3.0',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/site_Mega_Stacker_Rodeio_3.0.png?mtime=20250120120301&focal=none',
    price: 'R$ 38,00',
    weight: '380g',
    kcal: '820 kcal',
  },
  {
    id: '3',
    name: 'Whopper Rodeio',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/Whopper-Rodeio.png?mtime=20230731152626&focal=none',
    price: 'R$ 28,00',
    weight: '300g',
    kcal: '650 kcal',
  },
  {
    id: '4',
    name: 'Whopper Furioso',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/Whopper-Furioso.png?mtime=20230731152817&focal=none',
    price: 'R$ 30,00',
    weight: '320g',
    kcal: '680 kcal',
  },
  {
    id: '5',
    name: 'Whopper Duplo',
    image: 'https://d3sn2rlrwxy0ce.cloudfront.net/whopper-duplo-thumb.png?mtime=20210916101816&focal=none',
    price: 'R$ 32,00',
    weight: '340g',
    kcal: '720 kcal',
  },
];

export default function Dashboard({ navigation }) {
  const [selectedBurger, setSelectedBurger] = useState(null);

  // Logout
  const handleLogout = () => navigation.replace('Login');

  const renderItem = ({ item }) => (
    <TouchableOpacity style={styles.card} onPress={() => setSelectedBurger(item)}>
      <Image source={{ uri: item.image }} style={styles.cardImage} />
      <Text style={styles.cardTitle}>{item.name}</Text>
    </TouchableOpacity>
  );

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>Bem-vindo ao Burger King!</Text>

      <FlatList
        data={burgers}
        renderItem={renderItem}
        keyExtractor={(item) => item.id}
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ paddingBottom: 40 }}
      />

      <TouchableOpacity
        style={[styles.button, { marginTop: 20 }]}
        onPress={handleLogout}
      >
        <Text style={styles.buttonText}>SAIR</Text>
      </TouchableOpacity>

      {/* Modal com detalhes do hambúrguer */}
      <Modal
        visible={selectedBurger !== null}
        animationType="slide"
        transparent={true}
        onRequestClose={() => setSelectedBurger(null)}
      >
        <View style={{
          flex: 1,
          backgroundColor: 'rgba(0,0,0,0.5)',
          justifyContent: 'center',
          alignItems: 'center',
        }}>
          <View style={{
            width: '85%',
            backgroundColor: '#fff',
            borderRadius: 20,
            padding: 20,
            alignItems: 'center',
          }}>
            {selectedBurger && (
              <>
                <Image
                  source={{ uri: selectedBurger.image }}
                  style={{ width: 200, height: 150, borderRadius: 15, marginBottom: 10 }}
                />
                <Text style={{ fontSize: 20, fontWeight: 'bold', marginBottom: 5 }}>
                  {selectedBurger.name}
                </Text>
                <Text>Preço: {selectedBurger.price}</Text>
                <Text>Gramatura: {selectedBurger.weight}</Text>
                <Text>Calorias: {selectedBurger.kcal}</Text>

                <TouchableOpacity
                  onPress={() => setSelectedBurger(null)}
                  style={[styles.button, { marginTop: 15, paddingHorizontal: 50 }]}
                >
                  <Text style={styles.buttonText}>Fechar</Text>
                </TouchableOpacity>
              </>
            )}
          </View>
        </View>
      </Modal>
    </SafeAreaView>
  );
}
