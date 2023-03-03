import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../auth.dart';
import 'bottom_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? errorMessage = "";
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    _controllerEmail.text = "";
    _controllerPassword.text = "";
    super.initState();
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      final data = {
        "name": _controllerName.text,
        "email": _controllerEmail.text
      };

      await FirebaseFirestore.instance.collection('users').add(data);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 245, 243, 1),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // const Image(
                  //   height: 90,
                  //   image: AssetImage('assets/images/distance.png'),
                  // ),
                  // const Gap(10),
                  // const Text(
                  //   'myhighst map',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 35,
                  //   ),
                  // ),
                  const Gap(100),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(30),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextField(
                      controller: _controllerName,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person_2),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Your name",
                          focusedBorder: InputBorder.none,
                          focusColor: Colors.transparent),
                    ),
                  ),
                  const Gap(30),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                  const Gap(30),
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
                      onPressed: () {
                        _createUserWithEmailAndPassword();

                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          text: "Sign up was successful!",
                        );

                        Future.delayed(
                            const Duration(seconds: 2),
                            () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const BottomBar(),
                                  ),
                                ));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
