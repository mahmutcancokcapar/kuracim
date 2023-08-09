import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AdHelper {
  static BannerAd? _bannerAd;

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId:
          'ca-app-pub-3940256099942544/6300978111', //ca-app-pub-7677750212299055/6163604274
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        // ignore: avoid_print
        print('Banner Ad loaded.');
      }),
    );
  }

  static Future<bool> isConnectedToInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<void> loadBannerAdIfPossible() async {
    if (await isConnectedToInternet()) {
      _bannerAd = createBannerAd()..load();
    } else {
      // ignore: avoid_print
      print('No internet connection, banner ad not loaded.');
    }
  }

  static void dispose() {
    _bannerAd?.dispose();
  }
}
