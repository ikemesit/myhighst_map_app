import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:myhighst_map_app/screens/profile/profile_page.dart';
import 'package:myhighst_map_app/screens/signup/signup_screen.dart';
import 'package:myhighst_map_app/widgets/app_filled_button.dart';

import '../../services/auth/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage = "";
  bool _submitted = false;

  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    signInWithEmailAndPassword() {
      setState(() => _submitted = true);

      if (_formKey.currentState!.validate()) {
        try {
          Auth()
              .signInWithEmailAndPassword(
            email: _email,
            password: _password,
          )
              .then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          });
        } catch (e) {
          setState(() {
            errorMessage = e.toString();

            GFToast.showToast(errorMessage, context,
                toastDuration: 4,
                toastPosition: GFToastPosition.BOTTOM,
                textStyle: const TextStyle(fontSize: 12, color: GFColors.WHITE),
                backgroundColor: GFColors.DARK,
                toastBorderRadius: 8.0,
                trailing: const Icon(
                  Icons.error,
                  color: GFColors.DANGER,
                ));
          });
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const Gap(20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          autovalidateMode: _submitted
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          decoration: const InputDecoration(
                            // icon: Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            hintText: "Email",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            focusColor: Colors.transparent,
                          ),
                          onChanged: (value) => setState(() => _email = value),
                        ),
                        const Gap(20),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              // icon: Icon(Icons.password),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              hintText: "Password",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              focusColor: Colors.transparent),
                          onChanged: (value) =>
                              setState(() => _password = value),
                        ),
                        const Gap(30),
                        ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: double.infinity,
                              maxWidth: double.infinity,
                            ),
                            child: AppFilledButton(
                              label: 'Sign In',
                              submitEventCallback: () =>
                                  signInWithEmailAndPassword,
                              icon: const Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                            )),
                      ],
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
