import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/common_widgets/app_filled_button.dart';
import 'package:myhighst_map_app/screens/home/home_screen.dart';

import '../../data/auth.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
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
    final auth = ref.read(authProvider);
    try {
      await auth.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      final data = {
        'firstName': _controllerFirstName.text,
        'lastName': _controllerLastName.text,
        'fullName': '${_controllerFirstName.text} ${_controllerLastName.text}',
        'email': _controllerEmail.text,
        'createdAt': Timestamp.now(),
        'uid': auth.currentUser?.uid,
        'photoUrl': null,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(data['uid'] as String?)
          .set(data);

      await auth.currentUser?.updateDisplayName(_controllerFirstName.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider);

    onSignUpEventHandler() {
      if (_signUpFormKey.currentState!.validate()) {
        _createUserWithEmailAndPassword().then((value) {
          if (auth.currentUser != null) {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: 'Sign Up Success!',
              backgroundColor: Colors.white,
            ).then((value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                ));
          } else {
            CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: errorMessage,
              backgroundColor: Colors.white,
            );
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Form(
                key: _signUpFormKey,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: TextFormField(
                        controller: _controllerFirstName,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_2),
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Your first name",
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: TextFormField(
                        controller: _controllerLastName,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_2),
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Your last name",
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: TextFormField(
                        controller: _controllerEmail,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: TextFormField(
                        controller: _controllerPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: TextFormField(
                        controller: _controllerCPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          border: OutlineInputBorder(),
                          hintText: "Confirm Password",
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }

                          if (value != _controllerPassword.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
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
            ),
          ),
        ));
  }
}
