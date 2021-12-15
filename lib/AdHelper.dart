import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3938965156773479/2469183494';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3938965156773479/2469183494';
    }
    throw new UnsupportedError("Unsupported platform");
  }
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3938965156773479/3447331040";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3938965156773479/3447331040";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw new UnsupportedError("Unsupported platform");
  }
}