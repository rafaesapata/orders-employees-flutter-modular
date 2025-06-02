enum FirebaseFeatureFlagEnum { login, registration }

extension FirebaseFeatureFlagEnumExtension on FirebaseFeatureFlagEnum {
  String get value => switch (this) {
        FirebaseFeatureFlagEnum.login => 'feature_flag_login',
        FirebaseFeatureFlagEnum.registration => 'feature_flag_registration',
      };
}
