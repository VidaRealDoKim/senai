import { StatusBar } from 'expo-status-bar';
import React, { useState } from 'react';
import { StyleSheet, Text, View, Modal, Image, ScrollView, Alert, TextInput, TouchableOpacity } from 'react-native';

export default function App() {

  // -------------------------------
  // Estado principal de produtos
  // -------------------------------
  const [products, setProducts] = useState([
    {
      id: 1,
      title: "Tênis Esportivo Masculino",
      price: 299.90,
      image: "https://picsum.photos/300/200",
      description: "Tênis confortável e leve, ideal para corrida e treino diário."
    },
    {
      id: 2,
      title: "Camiseta Casual",
      price: 89.90,
      image: "https://picsum.photos/300/201",
      description: "Camiseta leve, perfeita para o dia a dia."
    }
  ]);

  // -------------------------------
  // Modal de detalhes do produto
  // -------------------------------
  const [selectedProduct, setSelectedProduct] = useState(null);

  // -------------------------------
  // Modal de edição do produto
  // -------------------------------
  const [editProduct, setEditProduct] = useState(null);
  const [editTitle, setEditTitle] = useState("");
  const [editPrice, setEditPrice] = useState("");

  // -------------------------------
  // Função abrir modal de detalhes
  // -------------------------------
  const openModal = (product) => setSelectedProduct(product);

  // -------------------------------
  // Fechar modal de detalhes
  // -------------------------------
  const closeModal = () => setSelectedProduct(null);

  // -------------------------------
  // Adicionar produto de teste
  // -------------------------------
  const addProduct = () => {
    const newProduct = {
      id: products.length + 1,
      title: "Produto Teste " + (products.length + 1),
      price: Math.floor(Math.random() * 500) + 50,
      image: "https://picsum.photos/300/" + (200 + products.length),
      description: "Descrição de teste do produto " + (products.length + 1)
    };
    setProducts([...products, newProduct]);
  };

  // -------------------------------
  // Deletar produto
  // -------------------------------
  const deleteProduct = (id) => {
    Alert.alert(
      "Deletar Produto",
      "Deseja realmente deletar este produto?",
      [
        { text: "Cancelar", style: "cancel" },
        {
          text: "Deletar",
          style: "destructive",
          onPress: () => {
            setProducts(products.filter(p => p.id !== id));
          }
        }
      ]
    );
  };

  // -------------------------------
  // Iniciar edição de produto
  // -------------------------------
  const startEditProduct = (product) => {
    setEditProduct(product);
    setEditTitle(product.title);
    setEditPrice(product.price.toString());
  };

  // -------------------------------
  // Salvar edição do produto
  // -------------------------------
  const saveEditProduct = () => {
    setProducts(products.map(p => {
      if (p.id === editProduct.id) {
        return { ...p, title: editTitle, price: parseFloat(editPrice) };
      }
      return p;
    }));
    setEditProduct(null);
  };

  // -------------------------------
  // Botão futurista reutilizável
  // -------------------------------
  const FuturisticButton = ({ title, onPress, styleText }) => (
    <TouchableOpacity style={styles.buttonFuturistic} onPress={onPress}>
      <Text style={[styles.buttonTextFuturistic, styleText]}>{title}</Text>
    </TouchableOpacity>
  );

  // -------------------------------
  // Renderização do app
  // -------------------------------
  return (
    <ScrollView contentContainerStyle={styles.container}>
      {/* Botão para adicionar produto */}
      <FuturisticButton title="Adicionar Produto" onPress={addProduct} />

      {/* Lista de produtos */}
      {products.map((product) => (
        <View key={product.id} style={styles.card}>
          <Image source={{ uri: product.image }} style={styles.productImage} />
          <Text style={styles.productTitle}>{product.title}</Text>
          <Text style={styles.productPrice}>R$ {product.price.toFixed(2)}</Text>

          <View style={{ flexDirection: "row", justifyContent: "space-between", width: "100%" }}>
            <FuturisticButton title="Ver Mais" onPress={() => openModal(product)} />
            <FuturisticButton title="Editar" onPress={() => startEditProduct(product)} />
            <FuturisticButton title="Deletar" onPress={() => deleteProduct(product.id)} styleText={{ color: '#FF4C4C' }} />
          </View>
        </View>
      ))}

      {/* Modal de detalhes */}
      <Modal
        animationType="slide"
        transparent={true}
        visible={selectedProduct !== null}
        onRequestClose={closeModal}
      >
        <View style={styles.modalBackground}>
          <View style={styles.modalContent}>
            {selectedProduct && (
              <>
                <Image source={{ uri: selectedProduct.image }} style={styles.modalImage} />
                <Text style={styles.modalTitle}>{selectedProduct.title}</Text>
                <Text style={styles.modalDescription}>{selectedProduct.description}</Text>
                <Text style={styles.modalPrice}>R$ {selectedProduct.price.toFixed(2)}</Text>
                <FuturisticButton title="Fechar" onPress={closeModal} />
              </>
            )}
          </View>
        </View>
      </Modal>

      {/* Modal de edição */}
      <Modal
        animationType="slide"
        transparent={true}
        visible={editProduct !== null}
        onRequestClose={() => setEditProduct(null)}
      >
        <View style={styles.modalBackground}>
          <View style={styles.modalContent}>
            {editProduct && (
              <>
                <Text style={styles.modalTitle}>Editar Produto</Text>
                <TextInput
                  style={styles.input}
                  value={editTitle}
                  onChangeText={setEditTitle}
                  placeholder="Título"
                />
                <TextInput
                  style={styles.input}
                  value={editPrice}
                  onChangeText={setEditPrice}
                  placeholder="Preço"
                  keyboardType="numeric"
                />
                <FuturisticButton title="Salvar" onPress={saveEditProduct} />
                <FuturisticButton title="Cancelar" onPress={() => setEditProduct(null)} styleText={{ color: '#FF4C4C' }} />
              </>
            )}
          </View>
        </View>
      </Modal>

      <StatusBar style="auto" />
    </ScrollView>
  );
}

// -------------------------------
// Estilos atualizados - futurista
// -------------------------------
const styles = StyleSheet.create({
  container: {
    flexGrow: 1,
    backgroundColor: '#1A1A1A', // fundo escuro moderno
    alignItems: 'center',
    justifyContent: 'flex-start',
    padding: 20,
  },
  card: {
    width: 340,
    backgroundColor: '#222', // card escuro
    borderRadius: 16,
    padding: 20,
    marginBottom: 22,
    alignItems: 'center',
    shadowColor: '#9B30FF',
    shadowOpacity: 0.35,
    shadowOffset: { width: 0, height: 6 },
    shadowRadius: 10,
    elevation: 8,
  },
  productImage: {
    width: '100%',
    height: 180,
    borderRadius: 16,
    marginBottom: 14,
  },
  productTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
    textAlign: 'center',
    color: '#fff',
  },
  productPrice: {
    fontSize: 18,
    color: '#9B30FF',
    fontWeight: 'bold',
    marginBottom: 14,
  },
  modalBackground: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.75)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  modalContent: {
    width: '95%',
    backgroundColor: '#1F1F1F',
    borderRadius: 16,
    padding: 25,
    alignItems: 'center',
  },
  modalImage: {
    width: 280,
    height: 180,
    borderRadius: 16,
    marginBottom: 18,
  },
  modalTitle: {
    fontSize: 22,
    fontWeight: 'bold',
    marginBottom: 12,
    textAlign: 'center',
    color: '#fff',
  },
  modalDescription: {
    fontSize: 17,
    marginBottom: 12,
    textAlign: 'center',
    color: '#ccc',
  },
  modalPrice: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#9B30FF',
    marginBottom: 20,
  },
  input: {
    width: '100%',
    borderColor: '#9B30FF',
    borderWidth: 2,
    borderRadius: 12,
    padding: 12,
    marginBottom: 12,
    fontSize: 16,
    color: '#fff',
    backgroundColor: '#333',
  },
  buttonFuturistic: {
    backgroundColor: '#000',
    paddingVertical: 14,
    paddingHorizontal: 22,
    borderRadius: 14,
    margin: 5,
    alignItems: 'center',
    shadowColor: '#9B30FF',
    shadowOpacity: 0.6,
    shadowOffset: { width: 0, height: 6 },
    shadowRadius: 10,
    elevation: 8,
  },
  buttonTextFuturistic: {
    color: '#9B30FF',
    fontWeight: 'bold',
    fontSize: 16,
    letterSpacing: 0.5,
  },
});
