class ModelGraph {
  final String name;
  final int value1;
  final int value2;

  ModelGraph(this.name, this.value1, this.value2);
    
  Map<String, List<int>> toMap() {
    return {
      name: [value1, value2],
    };
  }
}
