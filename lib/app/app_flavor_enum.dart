enum AppFlavorEnum {
  dev,
  alfa,
  beta,
  prod,
}

class AppFlavor {
  static AppFlavorEnum flavor = AppFlavorEnum.alfa;

  static String get name => flavor.name;

  static String get title {
    switch (flavor) {
      case AppFlavorEnum.dev:
        return 'Starterkit DEV';
      case AppFlavorEnum.alfa:
        return 'Starterkit ALFA';
      case AppFlavorEnum.beta:
        return 'Starterkit BETA';
      case AppFlavorEnum.prod:
        return 'Starterkit';
    }
  }
}
