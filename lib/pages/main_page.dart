import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../service/ad_helper.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late BannerAd _bannerAd;
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = AdHelper.createBannerAd(); // Reklamı oluştur
    _loadBannerAd(); // Reklamı yükle
  }

  Future<void> _loadBannerAd() async {
    await _bannerAd.load(); // Reklamı yükle
    _isBannerAdLoaded = true; // Reklam yüklendiğinde durumu güncelle
    setState(() {}); // Widget ağacını güncellemek için setState çağrısı
  }

  @override
  void dispose() {
    _bannerAd.dispose(); // Reklamı bellekten temizle
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'KURACIM',
                  style: GoogleFonts.spaceGrotesk(fontSize: 25),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Divider(),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Kuracım Nedir?',
                    style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 50,
                  maxHeight: 150,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'Çekiliş yapmak, grup ayarlamak, yazı tura atmak, kura çekmek gibi hayatı kolaylaştıran aktivitelerde size yardım eden bir uygulamadır.',
                        style: GoogleFonts.raleway(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Çekiliş Nasıl Yapılır?',
                    style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 50,
                  maxHeight: 150,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'Soldaki açılır menüden (sol üst köşede bulunan hamburger ikonuna basın veya ekranı sağa doğru çekin) Çekiliş Yap butonuna basarak ulaşabilirsiniz. Önce çekilişe katılacakları ayarlayın, ardından çekilişte verilecek hediyeleri ayarlayın. Her hediye çekilişe katılan 1 kişiye verilecektir.',
                        style: GoogleFonts.raleway(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Grup Ayarlama Nasıl Yapılır?',
                    style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 50,
                  maxHeight: 150,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'Soldaki açılır menüden Grup Ayarlama kısmına basın ve gruplanacak kişilerin listesini oluşturun. Ardından kaç gruba ayrılacağını belirleyin ve işlemi başlatın.',
                        style: GoogleFonts.raleway(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Yazı Tura Atmak',
                    style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 50,
                  maxHeight: 150,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'Soldaki açılır menüden Yazı Tura At kısmına gidin ve yazı tura atma işlemini başlatın.',
                        style: GoogleFonts.raleway(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Kura Nasıl Çekilir?',
                    style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 50,
                  maxHeight: 150,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'Soldaki açılır menüden Kura Çek kısmına gidin ve kuraya katılacakların listesini ayarlayın. Ardından kuradan kaç kişi seçileceğini seçin ve kura çekme işlemini başlatın.',
                        style: GoogleFonts.raleway(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Görüş ve Önerileriniz',
                    style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 50,
                  maxHeight: 150,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'Görüş ve önerileriniz bizim için çok önemlidir. Soldaki açılır menüden \'Görüş ve Önerileriniz\' sekmesine girip bize ulaşabilirsiniz.',
                        style: GoogleFonts.raleway(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
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
