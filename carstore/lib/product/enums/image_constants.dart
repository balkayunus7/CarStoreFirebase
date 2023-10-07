enum IconContants {
  phone('ic_phone');

  final String value;
  // ignore: sort_constructors_first
  const IconContants(this.value);

  String get toPng => 'assets/icon/$value.png';
}
