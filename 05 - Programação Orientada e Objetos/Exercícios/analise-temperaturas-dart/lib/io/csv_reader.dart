
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:analise_temperaturas_dart/model/temperature_record.dart';

class CsvReader {
  static Future<List<TemperatureRecord>> read(String path) async {
    final input = await File(path).readAsString();
    final rows = const CsvToListConverter().convert(input, eol: "\n");
    return rows.skip(1).map((r) => TemperatureRecord.fromCsv(
      [r[0].toString(), r[1].toString(), r[2].toString()]
    )).toList();
  }
}
