class StringException implements Exception {
  String error;
  StringException(this.error);

  @override
  String toString() {
    return error;
  }
}
