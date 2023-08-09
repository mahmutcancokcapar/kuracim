import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../service/ad_helper.dart';

class YaziTura extends StatefulWidget {
  const YaziTura({super.key});

  @override
  State<YaziTura> createState() => _YaziTuraState();
}

class _YaziTuraState extends State<YaziTura>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late String _result = '';
  late BannerAd _bannerAd;
  bool _isBannerAdLoaded = false;

  Future<void> _loadBannerAd() async {
    await _bannerAd.load(); // Reklamı yükle
    _isBannerAdLoaded = true; // Reklam yüklendiğinde durumu güncelle
    setState(() {}); // Widget ağacını güncellemek için setState çağrısı
  }

  @override
  void initState() {
    super.initState();
    _bannerAd = AdHelper.createBannerAd(); // Reklamı oluştur
    _loadBannerAd(); // Reklamı yükle
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _result = _getRandomResult(); // Rastgele sonuç al
        });
      }
    });
  }

  @override
  void dispose() {
    _bannerAd.dispose(); // Reklamı bellekten temizle
    _animationController.dispose();
    super.dispose();
  }

  void _startTossAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  String _getRandomResult() {
    // Rastgele bir sonuç seçmek için
    return (DateTime.now().millisecondsSinceEpoch % 2 == 0) ? 'Yazı' : 'Tura';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yazı Tura At',
          style: GoogleFonts.spaceGrotesk(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 120,
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                          0.0,
                          -200 * _animation.value +
                              200 * _animation.value * _animation.value),
                      child: Transform.rotate(
                        angle: _animation.value * 6.3,
                        child: child,
                      ),
                    );
                  },
                  child: (_result.isEmpty)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/yazi.png', width: 100),
                            const SizedBox(width: 30),
                            Image.asset('assets/images/tura.png', width: 100),
                          ],
                        )
                      : (_result == 'Yazı')
                          ? Image.asset('assets/images/yazi.png', width: 100)
                          : Image.asset('assets/images/tura.png', width: 100),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: _startTossAnimation,
                  child: Text(
                    'Yazı Tura At',
                    style: GoogleFonts.spaceGrotesk(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _result,
                      style: GoogleFonts.spaceGrotesk(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50.0, // Banner reklamın yüksekliği
        child: _isBannerAdLoaded
            ? AdWidget(ad: _bannerAd) // Reklamı AdWidget içinde kullan
            : const SizedBox.shrink(),
      ),
    );
  }
}
