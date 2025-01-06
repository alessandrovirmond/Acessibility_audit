
class ChartData {
  final String category;
  final int value1;
  final int value2;

  ChartData(this.category, this.value1, this.value2); 
}

List<ChartData> createChartData(Map<String, List<int>>? dataMap) {
  List<ChartData> chartDataList = [];

  if (dataMap != null) {
    dataMap.forEach((category, values) {
      if (values.length >= 2) {
      
        int value1 = values[0];
        int value2 = values[1];

        ChartData chartData = ChartData(category, value1, value2);
        chartDataList.add(chartData);
        
      }
    });
  }

  return chartDataList;
}

