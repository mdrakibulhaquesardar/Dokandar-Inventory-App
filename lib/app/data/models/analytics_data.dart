/// Analytics data model for Advanced Analytics module
class AnalyticsData {
  final String id;
  final String title;
  final String category;
  final Map<String, double> dataPoints; // date -> value
  final ChartType chartType;
  final DateTime createdAt;

  AnalyticsData({
    required this.id,
    required this.title,
    required this.category,
    required this.dataPoints,
    required this.chartType,
    required this.createdAt,
  });
}

enum ChartType {
  line,
  bar,
  pie,
  area,
}

/// Analytics summary model
class AnalyticsSummary {
  final String label;
  final double value;
  final double? previousValue;
  final String unit;
  final bool isPositive;

  AnalyticsSummary({
    required this.label,
    required this.value,
    this.previousValue,
    required this.unit,
    this.isPositive = true,
  });

  double? get changePercentage {
    if (previousValue == null || previousValue == 0) return null;
    return ((value - previousValue!) / previousValue!) * 100;
  }
}
