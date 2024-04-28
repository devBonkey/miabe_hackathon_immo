import 'package:fast_immo/helpers/utils.dart';
import 'package:fast_immo/pages/dashboard.dart';
import 'package:fast_immo/pages/login.dart';
import 'package:fast_immo/pages/register.dart';
import 'package:fast_immo/themes/colors.dart';
import 'package:fast_immo/widgets/button_transparent_bg.dart';
import 'package:fast_immo/widgets/button_white_bg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  initState() {
    checkUserAuth();
    super.initState();
  }

  checkUserAuth() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getInt("isLoggedIn") == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DashoardPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 100,
                ),
                const Text(
                  "FastImmo Togo",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Helpers.getVerticalSpacer(5),
                ButtonWhite(
                    text: "Connexion",
                    redirect: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    }),
                Helpers.getVerticalSpacer(1),
                ButtonTransparent(
                    text: "Inscription",
                    redirect: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    })
              ],
            ),
            const Positioned(
              bottom: 30,
              child: Text(
                "Accéder directement à l'application",
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
