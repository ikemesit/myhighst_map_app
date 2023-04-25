import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/common_widgets/app_filled_button.dart';
import 'package:myhighst_map_app/features/authentication/presentation/signup/signup_screen.dart';
import 'package:myhighst_map_app/global_states.dart';

import '../../../../services/auth/user.service.dart';
import '../../../profile/profile_page.dart';
import '../../data/auth.dart';
import 'login_screen.provider.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submitted = ref.watch(loginFormSubmittedProvider);
    final auth = ref.read(authProvider);
    final currentUser = ref.watch(currentUserProvider);

    signInWithEmailAndPassword() {
      ref.read(loginFormSubmittedProvider.notifier).state = true;
      final buttonState =
          ref.read(appFilledButtonLoadingStateProvider.notifier);

      final email = ref.read(emailInputProvider.notifier).state;
      final password = ref.read(passwordInputProvider.notifier).state;

      // Toggle loading button
      buttonState.toggleState();

      if (_formKey.currentState!.validate()) {
        auth
            .signInWithEmailAndPassword(
          email: email!,
          password: password!,
        )
            .then((value) {
          buttonState.toggleState();

          ref
              .read(userServiceProvider)
              .getUserById(auth.currentUser?.uid)
              .then((value) {
            ref.watch(currentUserProvider.notifier).state = value;
          });

          if (auth.currentUser != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          }
        }).catchError((error) {
          buttonState.toggleState();
          final errorMessage = error.toString();

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.amber,
        elevation: 0,
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
                          autovalidateMode: submitted
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
                          onChanged: (value) => ref
                              .read(emailInputProvider.notifier)
                              .state = value,
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
                          onChanged: (value) => ref
                              .read(passwordInputProvider.notifier)
                              .state = value,
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
                            builder: (context) => SignUpScreen(),
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
