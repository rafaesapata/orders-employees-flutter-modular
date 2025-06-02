import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';

class FirebaseRemoteConfigProvider {
  Future<void> initialize() async {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(hours: 12),
      ),
    );

    await FirebaseRemoteConfig.instance.setDefaults({});
    await _updateConfig();
    _listenUpdates();
  }

  Future<void> _updateConfig() async {
    try {
      await FirebaseRemoteConfig.instance.fetchAndActivate();
    } catch (e) {
      debugPrint('FRC updateConfig => Error ${e.toString()}');
    }
  }

  void _listenUpdates() => FirebaseRemoteConfig.instance.onConfigUpdated
      .listen((event) async => await _updateConfig());

  bool getBool(String key) => FirebaseRemoteConfig.instance.getBool(key);

  String getString(String key) => FirebaseRemoteConfig.instance.getString(key);
}
