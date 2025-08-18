
# Sistema de Análise de Temperaturas (Dart – POO)

Projeto didático em **Dart** para a avaliação prática *Sistema de Análise de Temperaturas*:

- Lê um CSV com leituras (timestamp, sensor_id, temperatura em °C)
- Calcula estatísticas (mínima, máxima, média, mediana, desvio padrão)
- Detecta alertas (abaixo do limite de frio e acima do limite de calor)
- Gera relatórios em `out/` (`resumo.txt` e `alertas.csv`)

## Como executar

1. Instalar as dependências:
```bash
dart pub get
```

2. Rodar o programa:
```bash
dart run bin/main.dart
```

## Estrutura
```
analise-temperaturas-dart/
├── bin/main.dart
├── lib/
│   ├── model/
│   ├── service/
│   ├── util/
│   └── io/
├── data/temperaturas.csv
└── out/ (gerado em runtime)
```

## Ajustes
- Arquivo de entrada: `data/temperaturas.csv`
- Limites de alerta: definidos em `bin/main.dart`
