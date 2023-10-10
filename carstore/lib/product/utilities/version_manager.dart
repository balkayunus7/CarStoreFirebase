import 'package:carstore/product/utilities/exception/custom_exception.dart';

class VersionManager {
  VersionManager({required this.deviceValue, required this.databaeValue});

  final String deviceValue;
  final String databaeValue;

  bool isNeedUpdate() {
    final deviceNumberSplit = deviceValue.split('.').join();
    final databaseValueSplit = databaeValue.split('.').join();

    final deviceNumber = int.tryParse(deviceNumberSplit);
    final databaseNumber = int.tryParse(databaseValueSplit);

    if (deviceNumber == null || databaseNumber == null) {
      throw CustomVersionException(
        '$deviceNumber or $databaseNumber is not valid parse',
      );
    }

    return deviceNumber < databaseNumber;
  }
}
