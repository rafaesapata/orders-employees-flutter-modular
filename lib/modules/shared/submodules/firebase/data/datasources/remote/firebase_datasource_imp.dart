import 'package:firebase_core/firebase_core.dart';

import '../../../../../../../app/app_config.dart';
import '../../../firebase_config.dart';
import '../firebase_datasource.dart';

class FirebaseDatasourceImp implements FirebaseDatasource {
  @override
  Future<void> initialize() async => await Firebase.initializeApp(
        name: AppConfig.firebaseName,
        options: FirebaseConfig.currentPlatform,
      );
}
