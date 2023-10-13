import 'package:carstore/product/enums/platform_enum.dart';
import 'package:carstore/product/models/numbers.dart';
import 'package:carstore/product/utilities/firebase/firebase_collections.dart';
import 'package:carstore/product/utilities/version_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(const SplashState());

  Future<void> checkAppliactionVersion(String clientVersion) async {
    final databaseValue = await getVersionNumberFromDatabase();
    if (databaseValue == null || databaseValue.isEmpty) {
      state = state.copyWith(isRedirectHome: true);
      return;
    }
    final checkIsNeedForceUpdate =
        VersionManager(deviceValue: clientVersion, databaeValue: databaseValue);

    if (checkIsNeedForceUpdate.isNeedUpdate()) {
      state = state.copyWith(isRequriedForceUpdate: true);
      return;
    }

    state = state.copyWith(isRedirectHome: true);
  }

  Future<String?> getVersionNumberFromDatabase() async {
    // if user coming from browser, we dont need check version
    if (kIsWeb) return null;
    final response = await FirebaseCollections.version.reference
        .withConverter<Numbers>(
          fromFirestore: (snapshot, options) =>
              Numbers().fromFirebase(snapshot),
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .doc(PlatformEnum.versionName)
        .get();
    return response.data()?.number;
  }
}

class SplashState extends Equatable {
  const SplashState({this.isRequriedForceUpdate, this.isRedirectHome});

  final bool? isRequriedForceUpdate;
  final bool? isRedirectHome;

  @override
  List<Object?> get props => [isRequriedForceUpdate, isRedirectHome];

  SplashState copyWith({
    bool? isRequriedForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
      isRequriedForceUpdate:
          isRequriedForceUpdate ?? this.isRequriedForceUpdate,
      isRedirectHome: isRedirectHome ?? this.isRedirectHome,
    );
  }
}
