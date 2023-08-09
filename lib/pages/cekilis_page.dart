import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../service/ad_helper.dart';

class CekilisYap extends StatefulWidget {
  const CekilisYap({Key? key}) : super(key: key);

  @override
  State<CekilisYap> createState() => _CekilisYapState();
}

class _CekilisYapState extends State<CekilisYap> {
  TextEditingController kisiEkle = TextEditingController();
  TextEditingController hediyeEkle = TextEditingController();
  List<String> cekiliseKatilanlar = [];
  List<String> hediyeler = [];
  bool isKisiGirisBos = true;
  bool isHediyeGirisBos = true;
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

  void cekiliseKisiEkle(String kisiAdi) {
    setState(() {
      cekiliseKatilanlar.add(kisiAdi);
    });
  }

  void hediyeEklemek(String hediye) {
    setState(() {
      hediyeler.add(hediye);
    });
  }

  void cekilistenKisiKaldir(String kisiAdi) {
    setState(() {
      cekiliseKatilanlar.remove(kisiAdi);
    });
  }

  void hediyeCikarmak(String hediye) {
    setState(() {
      hediyeler.remove(hediye);
    });
  }

  void hepsiniTemizle() {
    setState(() {
      cekiliseKatilanlar.clear();
      hediyeler.clear();
    });
  }

  String cekilisYap(List<String> hediyeler, List<String> kisiler) {
    if (hediyeler.length > cekiliseKatilanlar.length) {
      String hata1 = "HATA\nÇekilişe katılan sayısı, hediye sayısından az!";
      return hata1;
    } else {
      Random random = Random();
      int hediyelerIndex = random.nextInt(hediyeler.length);
      int kisiIndex = random.nextInt(kisiler.length);
      String kazananHediye = hediyeler[hediyelerIndex];
      String kazananKisi = kisiler[kisiIndex];
      String tamMetin =
          "KAZANAN\n'$kazananHediye' ödülünü kazanan kişi\n$kazananKisi";
      return tamMetin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Çekiliş Yap',
          style: GoogleFonts.spaceGrotesk(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Çekilişe katılacakların listesini buradan ayarlayabilirsiniz',
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: TextField(
                  controller: kisiEkle,
                  cursorColor: Colors.blueGrey,
                  onChanged: (value) {
                    setState(() {
                      isKisiGirisBos = kisiEkle.text.isEmpty;
                    });
                  },
                  style: GoogleFonts.spaceGrotesk(fontSize: 15),
                  decoration: InputDecoration(
                    labelText:
                        'Çekilişe katılacakları buradan ekleyebilirsiniz',
                    labelStyle: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: isKisiGirisBos
                          ? null
                          : () {
                              cekiliseKisiEkle(kisiEkle.text);
                              setState(() {
                                kisiEkle.clear();
                              });
                            },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Çekilişe katılanlar',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Divider(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: cekiliseKatilanlar.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Çekilişe henüz kimseyi eklemediniz...',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cekiliseKatilanlar.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        cekiliseKatilanlar[index],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.spaceGrotesk(),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => cekilistenKisiKaldir(
                                            cekiliseKatilanlar[index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.brown,
              ),
              Text(
                'Çekilişte verilecek hediyeleri buradan ayarlayabilirsiniz',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.spaceGrotesk(fontSize: 15, color: Colors.cyan),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: TextField(
                  controller: hediyeEkle,
                  cursorColor: Colors.blueGrey,
                  style: GoogleFonts.spaceGrotesk(fontSize: 15),
                  onChanged: (value) {
                    setState(() {
                      isHediyeGirisBos = hediyeEkle.text.isEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    labelText:
                        'Çekilişte verilecek hediyeleri buradan ekleyebilirsiniz',
                    labelStyle: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: isHediyeGirisBos
                          ? null
                          : () {
                              hediyeEklemek(hediyeEkle.text);
                              setState(() {
                                hediyeEkle.clear();
                              });
                            },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Çekilişte Verilecek Hediyeler',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Divider(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: hediyeler.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Çekilişe henüz bir hediye eklemediniz...',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: hediyeler.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        hediyeler[index],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.spaceGrotesk(),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        ),
                                        onPressed: () =>
                                            hediyeCikarmak(hediyeler[index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:
                          cekiliseKatilanlar.isNotEmpty || hediyeler.isNotEmpty
                              ? hepsiniTemizle
                              : null,
                      child: Text(
                        'Hepsini Temizle',
                        style: GoogleFonts.spaceGrotesk(),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed:
                          hediyeler.isNotEmpty && cekiliseKatilanlar.isNotEmpty
                              ? () {
                                  String kazanan =
                                      cekilisYap(hediyeler, cekiliseKatilanlar);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                            kazanan,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.spaceGrotesk(
                                              fontSize: 15,
                                            ),
                                          ),
                                        );
                                      });
                                }
                              : null,
                      child: Text(
                        'Çekilişi Başlat',
                        style: GoogleFonts.spaceGrotesk(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
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
