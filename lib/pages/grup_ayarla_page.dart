import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../service/ad_helper.dart';

class GrupAyarla extends StatefulWidget {
  const GrupAyarla({super.key});

  @override
  State<GrupAyarla> createState() => _GrupAyarlaState();
}

class _GrupAyarlaState extends State<GrupAyarla> {
  TextEditingController grubaEkleController = TextEditingController();
  bool isTextFieldEmpty = true;
  List<String> gruplanacaklar = [];
  int grupSayisi = 1;
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

  void grupListEkle(String kisiAdi) {
    setState(() {
      gruplanacaklar.add(kisiAdi);
    });
  }

  void grupListKaldir(String kisiAdi) {
    setState(() {
      gruplanacaklar.remove(kisiAdi);
    });
  }

  void hepsiniTemizle() {
    setState(() {
      gruplanacaklar.clear();
      grupSayisi = 1;
    });
  }

  void grupSayisiAzalt() {
    if (grupSayisi == 1) {
      return;
    } else {
      setState(() {
        grupSayisi--;
      });
    }
  }

  void grupSayisiArttir() {
    setState(() {
      grupSayisi++;
    });
  }

  void gruplandir() {
    if (gruplanacaklar.isEmpty) {
      return;
    }

    if (grupSayisi > gruplanacaklar.length) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Hata',
              style: GoogleFonts.spaceGrotesk(),
            ),
            content: Text(
              'Grup sayısı, gruplandırılacak kişilerden fazla, lütfen düzeltiip tekrar deneyiniz.',
              style: GoogleFonts.spaceGrotesk(),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tamam',
                  style: GoogleFonts.spaceGrotesk(),
                ),
              ),
            ],
          );
        },
      );
    } else {
      List<List<String>> gruplar = [];
      int kisiSayisi = gruplanacaklar.length;
      int kisiPerGrup = (kisiSayisi / grupSayisi).ceil();

      gruplanacaklar.shuffle();

      for (int i = 0; i < grupSayisi; i++) {
        int start = i * kisiPerGrup;
        int end = (i + 1) * kisiPerGrup;
        if (end > kisiSayisi) {
          end = kisiSayisi;
        }
        gruplar.add(gruplanacaklar.sublist(start, end));
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Gruplar',
              style: GoogleFonts.spaceGrotesk(),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: gruplar.map((grup) {
                  return ListTile(
                    title: Text(
                      grup.join(", "),
                      style: GoogleFonts.spaceGrotesk(),
                    ),
                  );
                }).toList(),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Tamam',
                  style: GoogleFonts.spaceGrotesk(),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grup Ayarla',
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
                'Gruplandırılacak kişilerin listesini burdan ayarlayabilirsiniz',
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
                  controller: grubaEkleController,
                  cursorColor: Colors.blueGrey,
                  style: GoogleFonts.spaceGrotesk(fontSize: 15),
                  onChanged: (value) {
                    setState(() {
                      isTextFieldEmpty = grubaEkleController.text.isEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    labelText:
                        'Gruplandırılacak kişileri buradan ekleyebilirsiniz',
                    labelStyle: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: isTextFieldEmpty
                          ? null
                          : () {
                              grupListEkle(grubaEkleController.text);
                              setState(() {
                                grubaEkleController.clear();
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
                        'Gruplanacak Kişiler',
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
                        child: gruplanacaklar.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                ),
                                child: Text(
                                  'Henüz kimseyi eklemediniz...',
                                  style: GoogleFonts.spaceGrotesk(
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                ),
                                child: ListView.builder(
                                  itemCount: gruplanacaklar.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        gruplanacaklar[index],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.spaceGrotesk(),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          grupListKaldir(gruplanacaklar[index]);
                                        },
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.red,
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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    'Grup Sayısı',
                    style: GoogleFonts.spaceGrotesk(),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: grupSayisiAzalt,
                    icon: const Icon(
                      Icons.remove,
                    ),
                  ),
                  Text(
                    '$grupSayisi',
                    style: GoogleFonts.spaceGrotesk(),
                  ),
                  IconButton(
                    onPressed: grupSayisiArttir,
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Gruplandırılmaya eklenen kişiler ',
                      style: GoogleFonts.spaceGrotesk(color: Colors.cyan),
                    ),
                    Text(
                      '$grupSayisi',
                      style: GoogleFonts.spaceGrotesk(color: Colors.red),
                    ),
                    Text(
                      ' gruba ayırılacak.',
                      style: GoogleFonts.spaceGrotesk(color: Colors.cyan),
                    ),
                  ],
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
                  children: [
                    ElevatedButton(
                      onPressed: gruplanacaklar.isEmpty ? null : hepsiniTemizle,
                      child: Text(
                        'Hepsini Temizle',
                        style: GoogleFonts.spaceGrotesk(),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: gruplanacaklar.isEmpty ? null : gruplandir,
                      child: Text(
                        'Gruplandır',
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
