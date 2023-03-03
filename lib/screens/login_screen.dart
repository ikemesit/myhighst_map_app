import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myhighst_map_app/screens/sign_up.dart';

import '../auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = "";
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    _controllerEmail.text = "";
    _controllerPassword.text = "";
    super.initState();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Image(
                    height: 90,
                    image: AssetImage('assets/images/distance.png'),
                  ),
                  const Gap(10),
                  const Text(
                    'myhighst map',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const Gap(50),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextField(
                      controller: _controllerEmail,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          focusedBorder: InputBorder.none,
                          focusColor: Colors.transparent),
                    ),
                  ),
                  const Gap(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextField(
                      controller: _controllerPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          focusedBorder: InputBorder.none,
                          focusColor: Colors.transparent),
                    ),
                  ),
                  const Gap(30),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: double.infinity,
                      maxWidth: double.infinity,
                    ),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        fixedSize: const Size(320, 50),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: _signInWithEmailAndPassword,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text('Register'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
