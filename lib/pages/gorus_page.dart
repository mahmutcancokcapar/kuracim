import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class GorusPage extends StatefulWidget {
  const GorusPage({super.key});

  @override
  State<GorusPage> createState() => _GorusPageState();
}

class _GorusPageState extends State<GorusPage> {
  TextEditingController konuController = TextEditingController();
  TextEditingController aciklamaController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  bool isButtonEnabled = false;
  String konu = '';
  String aciklama = '';
  String mail = '';
  void _checkButtonState() {
    setState(() {
      if (konuController.text.isNotEmpty &&
          aciklamaController.text.isNotEmpty &&
          mailController.text.isNotEmpty) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
  }

  _sendMail() async {
    // Android and iOS
    String mailTo = "cokcapar@mcmedya.net"; // Gönderilecek mail adresi
    String dummyMessage = "$aciklama\n--------------------\n$mail";
    String subjectText = konu;

    final uri =
        'mailto:$mailTo?subject=${Uri.encodeFull(subjectText)}&body=${Uri.encodeFull(dummyMessage)}';

    try {
      // ignore: deprecated_member_use
      if (await canLaunch(uri)) {
        // ignore: deprecated_member_use
        await launch(uri);
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Hata',
                style: GoogleFonts.spaceGrotesk(),
                textAlign: TextAlign.center,
              ),
              content: Text(
                'Bir hata meydana geldi, lütfen daha sonra tekrar deneyiniz.',
                style: GoogleFonts.spaceGrotesk(),
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Hata',
              style: GoogleFonts.spaceGrotesk(),
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Bir hata meydana geldi, lütfen daha sonra tekrar deneyiniz.',
              style: GoogleFonts.spaceGrotesk(),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }
  }

  void _onButtonPressed() {
    if (isButtonEnabled) {
      _sendMail();
    }
  }

  @override
  void dispose() {
    konuController.dispose();
    aciklamaController.dispose();
    mailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Görüş ve Önerileriniz',
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: TextField(
                  controller: konuController,
                  maxLines: 1,
                  maxLength: 50,
                  style: GoogleFonts.spaceGrotesk(),
                  onChanged: (value) {
                    setState(() {
                      konu = value;
                      _checkButtonState();
                    });
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    labelText: 'Konu',
                    labelStyle: GoogleFonts.indieFlower(
                      color: const Color.fromARGB(255, 130, 126, 126),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        konuController.clear();
                      },
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: TextField(
                  controller: aciklamaController,
                  maxLines: 5,
                  maxLength: 150,
                  style: GoogleFonts.spaceGrotesk(),
                  onChanged: (value) {
                    setState(() {
                      aciklama = value;
                      _checkButtonState();
                    });
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    labelText: 'Açıklama',
                    labelStyle: GoogleFonts.indieFlower(
                      color: const Color.fromARGB(255, 130, 126, 126),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        aciklamaController.clear();
                      },
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: TextField(
                  controller: mailController,
                  maxLines: 1,
                  maxLength: 50,
                  style: GoogleFonts.spaceGrotesk(),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      mail = value;
                      _checkButtonState();
                    });
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5),
                    ),
                    labelText: 'E-Posta adresiniz',
                    labelStyle: GoogleFonts.indieFlower(
                      color: const Color.fromARGB(255, 130, 126, 126),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        mailController.clear();
                      },
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isButtonEnabled ? _onButtonPressed : null,
                    child: Text(
                      'Gönder',
                      style: GoogleFonts.spaceGrotesk(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
