
import 'package:analise_temperaturas_dart/model/temperature_record.dart';
import 'package:analise_temperaturas_dart/util/statistics.dart';

class TemperatureSummary {
  final double min, max, mean, median, stddev;
  final int totalReadings;
  final DateTime from, to;

  TemperatureSummary(this.min, this.max, this.mean, this.median, this.stddev,
      this.totalReadings, this.from, this.to);

  String pretty() => """
=== RESUMO DE TEMPERATURAS ===
Período: $from a $to
Leituras: $totalReadings
Mínima: ${min.toStringAsFixed(2)} °C
Máxima: ${max.toStringAsFixed(2)} °C
Média: ${mean.toStringAsFixed(2)} °C
Mediana: ${median.toStringAsFixed(2)} °C
Desvio Padrão: ${stddev.toStringAsFixed(2)}
""";
}

class TemperatureAlert {
  final DateTime timestamp;
  final String sensorId;
  final double value;
  final String type;
  final String message;

  TemperatureAlert(this.timestamp, this.sensorId, this.value, this.type, this.message);

  @override
  String toString() =>
      "$timestamp [$sensorId] $type ($value °C): $message";
}

class TemperatureAnalyzer {
  final List<TemperatureRecord> records;

  TemperatureAnalyzer(this.records);

  TemperatureSummary summarize() {
    if (records.isEmpty) {
      throw Exception("Sem dados para análise");
    }
    final temps = records.map((r) => r.temperatureC).toList();
    final min = Statistics.min(temps);
    final max = Statistics.max(temps);
    final mean = Statistics.mean(temps);
    final median = Statistics.median(temps);
    final stddev = Statistics.stddev(temps);
    final from = records.first.timestamp;
    final to = records.last.timestamp;

    return TemperatureSummary(min, max, mean, median, stddev,
        records.length, from, to);
  }

  List<TemperatureAlert> detectAlerts(double low, double high) {
    return records.map((r) {
      if (r.temperatureC < low) {
        return TemperatureAlert(r.timestamp, r.sensorId, r.temperatureC,
            "FRIO", "Abaixo do limite ($low °C)");
      } else if (r.temperatureC > high) {
        return TemperatureAlert(r.timestamp, r.sensorId, r.temperatureC,
            "CALOR", "Acima do limite ($high °C)");
      }
      return null;
    }).whereType<TemperatureAlert>().toList();
  }
}
