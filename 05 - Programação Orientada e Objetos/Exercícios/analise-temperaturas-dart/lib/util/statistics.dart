
import 'dart:math';

class Statistics {
  static double min(List<double> xs) => xs.reduce((a, b) => a < b ? a : b);
  static double max(List<double> xs) => xs.reduce((a, b) => a > b ? a : b);
  static double mean(List<double> xs) => xs.reduce((a, b) => a + b) / xs.length;

  static double median(List<double> xs) {
    final sorted = [...xs]..sort();
    final n = sorted.length;
    if (n.isOdd) return sorted[n ~/ 2];
    return (sorted[n ~/ 2 - 1] + sorted[n ~/ 2]) / 2.0;
  }

  static double stddev(List<double> xs) {
    final m = mean(xs);
    final sum = xs.map((x) => pow(x - m, 2)).reduce((a, b) => a + b);
    return sqrt(sum / xs.length);
  }
}
