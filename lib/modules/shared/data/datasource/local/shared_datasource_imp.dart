import 'package:permission_handler/permission_handler.dart';

import '../../../submodules/rest/data/provider/rest_provider_imp.dart';
import '../../../domain/consts/shared_endpoints.dart';
import '../../../domain/entities/user_entity.dart';
import '../../models/user_model.dart';
import '../shared_datasource.dart';

class SharedDatasourceImp implements SharedDatasource {
  final RestProvider restClient;

  SharedDatasourceImp({required this.restClient});

  @override
  Future<UserEntity> fetchUserData() async {
    final response = await restClient.get(SharedEndpoints.fetchUser);
    return UserModel.fromMap(response.data);
  }

  @override
  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
      status = await Permission.storage.request();
    }
    return status == PermissionStatus.granted;
  }
}
