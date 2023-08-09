import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../pages/main_page.dart';
import 'drawer_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // 2 saniye bekleyin
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ZoomDrawer(
          menuScreen: const DrawerScreen(),
          mainScreen: const MainPage(),
          borderRadius: 30,
          angle: 0,
          showShadow: true,
          slideWidth: MediaQuery.of(context).size.width * 0.70,
          menuBackgroundColor: Colors.indigo,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.transparent,
          width: 150,
          height: 150,
          child: Image.asset(
            'assets/images/kuracim.png',
          ),
        ),
      ),
    );
  }
}
