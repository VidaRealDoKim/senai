
import 'dart:io';
import 'package:analise_temperaturas_dart/service/temperature_analyzer.dart';

class ReportWriter {
  static Future<void> writeSummary(String path, TemperatureSummary s) async {
    final file = File(path);
    await file.create(recursive: true);
    await file.writeAsString(s.pretty());
  }

  static Future<void> writeAlerts(String path, List<TemperatureAlert> alerts) async {
    final file = File(path);
    await file.create(recursive: true);
    final buffer = StringBuffer("timestamp,sensor_id,value_c,type,message\n");
    for (var a in alerts) {
      buffer.writeln("${a.timestamp},${a.sensorId},${a.value},${a.type},${a.message.replaceAll(",", ";")}");
    }
    await file.writeAsString(buffer.toString());
  }
}
