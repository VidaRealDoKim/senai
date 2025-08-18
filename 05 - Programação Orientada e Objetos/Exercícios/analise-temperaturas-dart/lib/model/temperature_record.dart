
class TemperatureRecord {
  final DateTime timestamp;
  final String sensorId;
  final double temperatureC;

  TemperatureRecord(this.timestamp, this.sensorId, this.temperatureC);

  factory TemperatureRecord.fromCsv(List<String> row) {
    return TemperatureRecord(
      DateTime.parse(row[0]),
      row[1].trim(),
      double.parse(row[2]),
    );
  }

  @override
  String toString() => "$timestamp,$sensorId,$temperatureC";
}
