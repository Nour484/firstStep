import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learningfirebase/constant/pattern.dart';
import 'package:learningfirebase/constant/textfield_const.dart';
import 'package:learningfirebase/screen/login_screen.dart';
import 'package:learningfirebase/widget/login_widget.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
//* signInWithFaceBook Method
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

//* signInWithGoogle Method
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  bool showPassword = true;
  bool showConfirmPassword = true;
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
            Form(
                key: _Keyform,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormFieldLoginWidget(
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.givenName],
                          textInputTypeTextField: TextInputType.name,
                          controllerTextField: firstName,
                          pattern: namePattern,
                          outLinedBorderTextfieldColor: Colors.brown,
                          widthSizeTextField: 2.333,
                          hintText: AppLocalizations.of(context)!.firstName,
                          preIcon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 140, 134, 132),
                          ),
                          obscuretext: false),
                      TextFormFieldLoginWidget(
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.familyName],
                          textInputTypeTextField: TextInputType.name,
                          controllerTextField: lastName,
                          pattern: namePattern,
                          obscuretext: false,
                          outLinedBorderTextfieldColor: Colors.brown,
                          widthSizeTextField: 2.333,
                          hintText: AppLocalizations.of(context)!.lastName,
                          preIcon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 140, 134, 132),
                          )),
                    ],
                  ),
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
                    textInputAction: TextInputAction.next,
                    autofillHints: [AutofillHints.password],
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
                  TextFormFieldLoginWidget(
                    autofillHints: [AutofillHints.password],
                    onEditingComplete: () => TextInput.finishAutofillContext(),
                    textInputTypeTextField: TextInputType.visiblePassword,
                    controllerTextField: confirmPassword,
                    pattern: passwordPattern,
                    obscuretext: showConfirmPassword,
                    outLinedBorderTextfieldColor: Colors.brown,
                    widthSizeTextField: 1.1,
                    hintText: AppLocalizations.of(context)!.confirmPassword,
                    preIcon: const Icon(
                      Icons.password_sharp,
                      color: Color.fromARGB(255, 140, 134, 132),
                    ),
                    sufIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                      icon: Icon(showConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      color: const Color.fromARGB(255, 140, 134, 132),
                    ),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(width: 2, color: Colors.brown),
                      ),
                      onPressed: () async {
                        if (_Keyform.currentState!.validate()) {
                          // ignore: avoid_print
                          print("done");
                          signUpEmailAndPassword(email.text, password.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70.0, vertical: 15),
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
                          style: TextStyle(color: Colors.brown.shade900),
                        ),
                      )),
                ])),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/facebook.jpg"),
                  ),
                  onTap: () async {
                    await signInWithFacebook().then((value) => Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        })));
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/google.jpg"),
                  ),
                  onTap: () async {
                    /*
                    await signInWithGoogle().then((value) => Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        })));
                  */
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/twitter.jpg"),
                )
              ],
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
                child: Text(
                  AppLocalizations.of(context)!.haveAnccount,
                  style: TextStyle(
                      fontFamily: AppLocalizations.of(context)!.fontStyle,
                      fontSize: 25,
                      color: Colors.brown.shade400),
                )),
          ],
        ),
      ),
    );
  }

//* signUpEmailAndPassword Method
  void signUpEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
