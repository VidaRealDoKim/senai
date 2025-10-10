import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, FlatList, Image, ActivityIndicator, TouchableOpacity, Linking, ScrollView } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Animated } from 'react-native';

export default function App() {
  const [rockets, setRockets] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('https://api.spacexdata.com/v4/rockets')
      .then((res) => res.json())
      .then((data) => {
        setRockets(data);
        setLoading(false);
      })
      .catch((err) => {
        console.log(err);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return (
      <LinearGradient colors={['#0f0c29', '#302b63', '#24243e']} style={styles.container}>
        <ActivityIndicator size="large" color="#fff" />
        <Text style={styles.loadingText}>Carregando foguetes...</Text>
      </LinearGradient>
    );
  }

  const renderRocket = ({ item }) => (
    <TouchableOpacity
      style={styles.card}
      activeOpacity={0.8}
      onPress={() => Linking.openURL(item.wikipedia)}
    >
      <Image source={{ uri: item.flickr_images[0] }} style={styles.image} />
      <View style={styles.cardInfo}>
        <Text style={styles.rocketName}>{item.name}</Text>
        <Text style={styles.desc}>{item.description.slice(0, 120)}...</Text>
        <View style={styles.cardFooter}>
          <Text style={styles.country}>{item.country}</Text>
          <Ionicons name="rocket-outline" size={18} color="#fff" />
        </View>
      </View>
    </TouchableOpacity>
  );

  return (
    <LinearGradient colors={['#0f0c29', '#302b63', '#24243e']} style={styles.container}>
      <StatusBar style="light" />
      <View style={styles.header}>
        <Ionicons name="planet-outline" size={26} color="#fff" />
        <Text style={styles.title}>Foguetes do Mundo</Text>
        <Ionicons name="planet-outline" size={26} color="#fff" />
      </View>
      <FlatList
        data={rockets}
        keyExtractor={(item) => item.id}
        renderItem={renderRocket}
        contentContainerStyle={{ paddingBottom: 50 }}
        showsVerticalScrollIndicator={false}
      />
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 50,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 20,
    gap: 10,
  },
  title: {
    color: '#fff',
    fontSize: 22,
    fontWeight: 'bold',
    letterSpacing: 2,
  },
  card: {
    backgroundColor: 'rgba(255,255,255,0.1)',
    borderRadius: 16,
    marginHorizontal: 16,
    marginVertical: 10,
    overflow: 'hidden',
    shadowColor: '#fff',
    shadowOpacity: 0.4,
    shadowRadius: 10,
  },
  image: {
    width: '100%',
    height: 220,
  },
  cardInfo: {
    padding: 12,
  },
  rocketName: {
    color: '#fff',
    fontSize: 20,
    fontWeight: 'bold',
  },
  desc: {
    color: '#ccc',
    marginTop: 8,
    fontSize: 14,
  },
  cardFooter: {
    marginTop: 10,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  country: {
    color: '#fff',
    fontSize: 13,
    opacity: 0.7,
  },
  loadingText: {
    color: '#fff',
    marginTop: 10,
    fontSize: 16,
  },
});
