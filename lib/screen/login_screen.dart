import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:learningfirebase/constant/pattern.dart';
import 'package:learningfirebase/constant/textfield_const.dart';
import 'package:learningfirebase/screen/home_screen.dart';
import 'package:learningfirebase/screen/signup_screen.dart';
import 'package:learningfirebase/widget/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final _Keyform = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Image(image: AssetImage("assets/images/finalLogo.jpg")),
            const SizedBox(
              height: 10,
            ),
            AutofillGroup(
              child: Form(
                  key: _Keyform,
                  child: Column(children: [
                    TextFormFieldLoginWidget(
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      textInputTypeTextField: TextInputType.emailAddress,
                      controllerTextField: email,
                      pattern: emailPattern,
                      obscuretext: false,
                      outLinedBorderTextfieldColor: Colors.brown,
                      widthSizeTextField: 1.1,
                      hintText: AppLocalizations.of(context)!.emailHint,
                      preIcon: const Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 140, 134, 132),
                      ),
                    ),
                    TextFormFieldLoginWidget(
                      autofillHints: [AutofillHints.password],
                      onEditingComplete: () =>
                          TextInput.finishAutofillContext(),
                      textInputTypeTextField: TextInputType.visiblePassword,
                      controllerTextField: password,
                      pattern: passwordPattern,
                      outLinedBorderTextfieldColor: Colors.brown,
                      widthSizeTextField: 1.1,
                      hintText: AppLocalizations.of(context)!.password,
                      preIcon: const Icon(
                        Icons.password_sharp,
                        color: Color.fromARGB(255, 140, 134, 132),
                      ),
                      sufIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: const Color.fromARGB(255, 140, 134, 132),
                      ),
                      obscuretext: showPassword,
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(width: 2, color: Colors.brown),
                        ),
                        onPressed: () async {
                          if (_Keyform.currentState!.validate()) {
                            // print("done");

                            loginWithEmailAndPassword(
                                email.text, password.text);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70.0, vertical: 15),
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: TextStyle(color: Colors.brown.shade900),
                          ),
                        )),
                  ])),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.createaccount,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.brown.shade400,
                  fontFamily: AppLocalizations.of(context)!.fontStyle,
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  void loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        //  print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      }
    }
  }
}
