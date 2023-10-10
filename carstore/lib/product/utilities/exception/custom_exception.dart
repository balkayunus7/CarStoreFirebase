class CustomFirebaseException implements Exception {
  CustomFirebaseException(this.description);

  final String description;
  @override
  String toString() {
    return '$this  $description';
  }
}

class CustomVersionException implements Exception {
  CustomVersionException(this.description);

  final String description;
  @override
  String toString() {
    return '$this  $description';
  }
}
