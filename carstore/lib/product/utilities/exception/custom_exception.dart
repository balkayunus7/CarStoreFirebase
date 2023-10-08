class CustomFirebaseException implements Exception {
  CustomFirebaseException(this.description);

  final String description;
  @override
  String toString() {
    return '$this  $description';
  }
}
