import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myhighst_map_app/custom_widgets/app_filled_button.dart';

import '../services/auth.dart';
import 'bottom_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? errorMessage = "";
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerCPassword = TextEditingController();

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
        'firstName': _controllerFirstName.text,
        'lastName': _controllerLastName.text,
        'fullName': '${_controllerFirstName.text} ${_controllerLastName.text}',
        'email': _controllerEmail.text,
        'dateRegistered': Timestamp.now(),
        'uid': Auth().currentUser?.uid
      };

      await FirebaseFirestore.instance.collection('users').add(data);
      await Auth().currentUser?.updateDisplayName(_controllerFirstName.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    onSignUpEventHandler() {
      _createUserWithEmailAndPassword();

      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Sign up was successful!",
      );

      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomBar(),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
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
                      controller: _controllerFirstName,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person_2),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Your first name",
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
                      controller: _controllerLastName,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person_2),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Your last name",
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    // margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextField(
                      controller: _controllerCPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Confirm Password",
                          focusedBorder: InputBorder.none,
                          focusColor: Colors.transparent),
                    ),
                  ),
                  const Gap(40),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: double.infinity,
                      maxWidth: double.infinity,
                    ),
                    child: AppFilledButton(
                      label: 'Sign Up',
                      submitEventCallback: () => onSignUpEventHandler,
                      icon: const Icon(
                        Icons.app_registration,
                        color: Colors.white,
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
