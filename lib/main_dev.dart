import 'app/app_builder.dart';
import 'app/app_flavor_enum.dart';

void main() {
  AppFlavor.flavor = AppFlavorEnum.dev;
  buildApp();
}
