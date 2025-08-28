import React, { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

// ----------------------------
// Inicializa o tabuleiro
// ----------------------------
const inicialTabuleiro = () => {
  const tabuleiro = Array(8).fill(null).map(() => Array(8).fill(null));

  // peças pretas
  for (let i = 0; i < 3; i++) {
    for (let j = 0; j < 8; j++) {
      if ((i + j) % 2 === 1) tabuleiro[i][j] = '⚫';
    }
  }

  // peças brancas
  for (let i = 5; i < 8; i++) {
    for (let j = 0; j < 8; j++) {
      if ((i + j) % 2 === 1) tabuleiro[i][j] = '⚪';
    }
  }

  return tabuleiro;
};

export default function App() {
  const [tabuleiro, setTabuleiro] = useState(inicialTabuleiro());
  const [selecionado, setSelecionado] = useState(null);
  const [turnoBranco, setTurnoBranco] = useState(true);

  // ----------------------------
  // Calcula movimentos válidos (simples e capturas)
  // ----------------------------
  const movimentosValidos = (linha, coluna) => {
    const peca = tabuleiro[linha][coluna];
    if (!peca) return [];

    const direcoes = [];
    const éBranco = peca[0] === '⚪';
    const éDama = peca.length === 2;

    // Peões podem mover apenas para frente; damas para todas diagonais
    if (éDama) {
      direcoes.push([-1, -1], [-1, 1], [1, -1], [1, 1]);
    } else {
      const dir = éBranco ? -1 : 1;
      direcoes.push([dir, -1], [dir, 1]);
    }

    const possiveis = [];

    // movimentos simples
    direcoes.forEach(([dl, dc]) => {
      const l = linha + dl;
      const c = coluna + dc;
      if (l >= 0 && l < 8 && c >= 0 && c < 8 && !tabuleiro[l][c]) {
        // para peões, só frente; damas podem todas
        if (éDama || (dl === (éBranco ? -1 : 1))) possiveis.push([l, c]);
      }
    });

    // capturas (para frente e para trás)
    [[-1, -1], [-1, 1], [1, -1], [1, 1]].forEach(([dl, dc]) => {
      const l1 = linha + dl;
      const c1 = coluna + dc;
      const l2 = linha + 2 * dl;
      const c2 = coluna + 2 * dc;
      if (
        l2 >= 0 &&
        l2 < 8 &&
        c2 >= 0 &&
        c2 < 8 &&
        tabuleiro[l1][c1] &&
        tabuleiro[l1][c1][0] !== peca[0] &&
        !tabuleiro[l2][c2]
      ) {
        possiveis.push([l2, c2]);
      }
    });

    return possiveis;
  };

  // ----------------------------
  // Move peça selecionada
  // ----------------------------
  const moverPeca = (linha, coluna) => {
    const peca = tabuleiro[linha][coluna];

    if (peca) {
      if ((turnoBranco && peca[0] === '⚪') || (!turnoBranco && peca[0] === '⚫')) {
        setSelecionado({ linha, coluna });
      }
      return;
    }

    if (selecionado) {
      const validos = movimentosValidos(selecionado.linha, selecionado.coluna);
      if (validos.some(([l, c]) => l === linha && c === coluna)) {
        const novaTabuleiro = tabuleiro.map(row => [...row]);
        const movL = linha - selecionado.linha;
        const movC = coluna - selecionado.coluna;

        // captura de peça adversária
        if (Math.abs(movL) === 2) {
          const meioL = selecionado.linha + movL / 2;
          const meioC = selecionado.coluna + movC / 2;
          novaTabuleiro[meioL][meioC] = null;
        }

        // move peça
        let novaPeca = novaTabuleiro[selecionado.linha][selecionado.coluna];

        // promoção a dama
        if (
          (novaPeca[0] === '⚪' && linha === 0) ||
          (novaPeca[0] === '⚫' && linha === 7)
        ) {
          novaPeca += 'D';
        }

        novaTabuleiro[linha][coluna] = novaPeca;
        novaTabuleiro[selecionado.linha][selecionado.coluna] = null;

        setTabuleiro(novaTabuleiro);
        setSelecionado(null);
        setTurnoBranco(!turnoBranco);
      }
    }
  };

  // ----------------------------
  // Renderização do tabuleiro
  // ----------------------------
  return (
    <View style={styles.container}>
      <Text style={styles.turno}>Turno: {turnoBranco ? 'Branco ⚪' : 'Preto ⚫'}</Text>
      {tabuleiro.map((linha, i) => (
        <View key={i} style={styles.row}>
          {linha.map((peca, j) => {
            const corCelula = (i + j) % 2 === 0 ? '#eee' : '#555';
            const highlight =
              selecionado && selecionado.linha === i && selecionado.coluna === j
                ? 'yellow'
                : corCelula;
            return (
              <TouchableOpacity
                key={j}
                style={[styles.celula, { backgroundColor: highlight }]}
                onPress={() => moverPeca(i, j)}
              >
                <Text style={styles.peca}>{peca}</Text>
              </TouchableOpacity>
            );
          })}
        </View>
      ))}
    </View>
  );
}

// ----------------------------
// Estilos
// ----------------------------
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#222',
    padding: 10,
  },
  row: {
    flexDirection: 'row',
  },
  celula: {
    width: 40,
    height: 40,
    justifyContent: 'center',
    alignItems: 'center',
  },
  peca: {
    fontSize: 24,
  },
  turno: {
    fontSize: 18,
    color: '#fff',
    marginBottom: 10,
  },
});
