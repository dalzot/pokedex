extension UpperCase on String {
  String firstUpperCase() {
    String firstChar = this[0];
    return "${firstChar.toUpperCase()}${this.substring(1)}";
  }
}