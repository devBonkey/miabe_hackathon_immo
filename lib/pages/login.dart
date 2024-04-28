import 'package:fast_immo/helpers/utils.dart';
import 'package:fast_immo/pages/dashboard.dart';
import 'package:fast_immo/services/firebase.dart';
import 'package:fast_immo/themes/colors.dart';
import 'package:fast_immo/widgets/button_white_bg.dart';
import 'package:fast_immo/widgets/field_white_bg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
            child: Stack(alignment: Alignment.center, children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bienvenue,",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Ravi de vous revoir!",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    Helpers.getVerticalSpacer(2),
                    FieldWhiteBg(
                      hintText: "Adresse mail",
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    Helpers.getVerticalSpacer(1),
                    FieldWhiteBg(
                      hintText: "Mot de passe",
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                    ),
                    Helpers.getVerticalSpacer(1),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Mot de passe oublié?",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Helpers.getVerticalSpacer(3),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ButtonWhite(
                            text: "Se Connecter",
                            redirect: () {
                              login();
                            }),
                    Helpers.getVerticalSpacer(1),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Ou Connectez-vous via",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
                    Helpers.getVerticalSpacer(1),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Image.asset(
                              "assets/google.png",
                              height: 40,
                            ),
                          ),
                        ),
                        Helpers.getHorizontalSpacer(1),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Image.asset(
                              "assets/facebook.png",
                              height: 40,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Positioned(
                  bottom: 30,
                  child: Row(
                    children: [
                      Text(
                        "Vous n'avez pas de compte? ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Créer maintenant",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white),
                      ),
                    ],
                  ))
            ])));
  }

  Future<void> login() async {
    final SharedPreferences prefs = await _prefs;

    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseService.registerUser(
              email: emailController.text, password: passwordController.text)
          .then((status) {
        setState(() {
          isLoading = false;
        });
        if (status) {
          prefs.setInt("isLoggedIn", 1);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashoardPage()));
        } else {
          showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                  content: Text("Erreur survenue, veuillez réessayer!")));
        }
      });
    }
  }
}
