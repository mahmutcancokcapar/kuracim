import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../service/ad_helper.dart';

class KuraCek extends StatefulWidget {
  const KuraCek({Key? key}) : super(key: key);

  @override
  State<KuraCek> createState() => _KuraCekState();
}

class _KuraCekState extends State<KuraCek> {
  TextEditingController kurayaEkle = TextEditingController();
  bool isKisiGirBos = true;
  List<String> kurayaKatilanlar = [];
  int kisiSayisi = 1;
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

  void kisiArttir() {
    if (kisiSayisi < kurayaKatilanlar.length) {
      setState(() {
        kisiSayisi++;
      });
    } else {
      return;
    }
  }

  void kisiAzalt() {
    if (kisiSayisi <= 1) {
      return;
    } else {
      setState(() {
        kisiSayisi--;
      });
    }
  }

  void kurayaKisiEkle(String kisiAdi) {
    setState(() {
      kurayaKatilanlar.add(kisiAdi);
    });
  }

  void kuradanKisiKaldir(String kisiAdi) {
    setState(() {
      kurayaKatilanlar.remove(kisiAdi);
    });
  }

  void hepsiniTemizle() {
    setState(() {
      kurayaKatilanlar.clear();
    });
  }

  String kuraCek(List<String> kuradakiler, int kisiSayisi) {
    if (kisiSayisi <= 0 || kisiSayisi > kuradakiler.length) {
      return 'Geçersiz kişi sayısı';
    }

    Random random = Random();
    List<String> kazananKisiler = [];

    while (kazananKisiler.length < kisiSayisi) {
      int kuraIndex = random.nextInt(kuradakiler.length);
      String kazananKisi = kuradakiler[kuraIndex];
      if (!kazananKisiler.contains(kazananKisi)) {
        kazananKisiler.add(kazananKisi);
      }
    }

    String tamMetin = 'KURA SONUCU\nKuradan çıkanlar:\n';
    for (String kazananKisi in kazananKisiler) {
      tamMetin += '$kazananKisi\n';
    }

    return tamMetin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kura Çek',
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
                'Kuraya katılacak kişilerin listesini buradan ayarlayabilirsiniz',
                style: GoogleFonts.spaceGrotesk(color: Colors.cyan),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  controller: kurayaEkle,
                  cursorColor: Colors.blueGrey,
                  onChanged: (value) {
                    setState(() {
                      isKisiGirBos = kurayaEkle.text.isEmpty;
                    });
                  },
                  style: GoogleFonts.spaceGrotesk(),
                  decoration: InputDecoration(
                    labelText: 'Kuraya katılacakları buradan ekleyebilirsiniz',
                    labelStyle: GoogleFonts.spaceGrotesk(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: isKisiGirBos
                          ? null
                          : () {
                              kurayaKisiEkle(kurayaEkle.text);
                              setState(() {
                                kurayaEkle.clear();
                              });
                            },
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
                        'Kuraya Katılanlar',
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
                        child: kurayaKatilanlar.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'Kuraya henüz kimseyi eklemediniz...',
                                  style: GoogleFonts.spaceGrotesk(
                                      color: Colors.red, fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                ),
                                child: ListView.builder(
                                  itemCount: kurayaKatilanlar.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        kurayaKatilanlar[index],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.spaceGrotesk(),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => kuradanKisiKaldir(
                                          kurayaKatilanlar[index],
                                        ),
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
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      'Kuradan seçilecek kişi sayısı',
                      style: GoogleFonts.spaceGrotesk(),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: kisiAzalt,
                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$kisiSayisi',
                    style: GoogleFonts.spaceGrotesk(),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: kisiArttir,
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ],
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
                          kurayaKatilanlar.isEmpty ? null : hepsiniTemizle,
                      child: Text(
                        'Hepsini Temizle',
                        style: GoogleFonts.spaceGrotesk(),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: kurayaKatilanlar.isNotEmpty
                          ? () {
                              String kazanalar =
                                  kuraCek(kurayaKatilanlar, kisiSayisi);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                      kazanalar,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.spaceGrotesk(
                                          fontSize: 15),
                                    ),
                                  );
                                },
                              );
                            }
                          : null,
                      child: Text(
                        'Kura Çekimini Başlat',
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
