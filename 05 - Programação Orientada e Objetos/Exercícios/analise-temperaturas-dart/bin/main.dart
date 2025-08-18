
import 'dart:io';
import 'package:analise_temperaturas_dart/io/csv_reader.dart';
import 'package:analise_temperaturas_dart/io/report_writer.dart';
import 'package:analise_temperaturas_dart/service/temperature_analyzer.dart';

void main(List<String> args) async {
  final csvPath = "data/temperaturas.csv";
  final low = 18.0;
  final high = 30.0;

  try {
    final records = await CsvReader.read(csvPath);

    final analyzer = TemperatureAnalyzer(records);
    final summary = analyzer.summarize();
    final alerts = analyzer.detectAlerts(low, high);

    await ReportWriter.writeSummary("out/resumo.txt", summary);
    await ReportWriter.writeAlerts("out/alertas.csv", alerts);

    print(summary.pretty());
    if (alerts.isNotEmpty) {
      print("\n--- ALERTAS ---");
      alerts.forEach(print);
    } else {
      print("\nSem alertas.");
    }
  } catch (e, st) {
    print("Erro: $e");
    print(st);
  }
}
