import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class SharedGetLocalImageUsecase {
  Future<XFile?> call(ImageSource imageSource);
}

class SharedGetLocalImageUsecaseImp extends SharedGetLocalImageUsecase {
  @override
  Future<XFile?> call(ImageSource imageSource) async =>
      imageSource == ImageSource.camera
          ? _getPictureFromCamera()
          : _getPictureFromGallery();

  Future<XFile?> _getPictureFromGallery() async {
    PermissionStatus status = await Permission.storage.status;

    if (status == PermissionStatus.denied) {
      status = await Permission.storage.request();

      if (status != PermissionStatus.granted) {
        return null;
      }
    }

    return await _getXFile(ImageSource.gallery);
  }

  Future<XFile?> _getPictureFromCamera() async {
    PermissionStatus status = await Permission.camera.status;

    if (status == PermissionStatus.denied) {
      status = await Permission.camera.request();

      if (status != PermissionStatus.granted) {
        return null;
      }
    }

    return await _getXFile(ImageSource.camera);
  }

  Future<XFile?> _getXFile(ImageSource imageSource) async {
    try {
      var picker = ImagePicker();

      XFile? image =
          await picker.pickImage(source: imageSource, imageQuality: 40);

      return image;
    } catch (e) {
      return null;
    }
  }
}
