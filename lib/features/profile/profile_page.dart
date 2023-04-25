import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/features/authentication/data/auth.dart';
import 'package:myhighst_map_app/features/profile/profile_edit.dart';

import '../../global_states.dart';
import '../../screens/home/home_screen.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  final _changePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    final currentUser = ref.watch(currentUserProvider);
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();

    updatePassword() {
      if (_changePasswordFormKey.currentState!.validate()) {
        auth.currentUser!.updatePassword(newPasswordController.text).then((_) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Password changed!",
            backgroundColor: Colors.white,
          ).then((value) => Navigator.pop(context));
        }).catchError((error) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: error.toString(),
            backgroundColor: Colors.white,
          );
        });
      }
    }

    showPasswordDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change password'),
            content: Form(
              key: _changePasswordFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'New password',
                    ),
                    controller: newPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Confirm new password',
                    ),
                    controller: confirmNewPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your new password';
                      }

                      if (value != newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  updatePassword();
                  // Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My profile',
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Center(
                        child: currentUser!.photoUrl!.isNotEmpty
                            ? GFAvatar(
                                backgroundImage: NetworkImage(
                                    currentUser.photoUrl as String),
                                radius: 60,
                              )
                            : const GFAvatar(
                                radius: 60,
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      const Gap(10),
                      Text(
                        currentUser.fullName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Gap(10),
            const Row(
              children: [
                Expanded(
                    child: Card(
                  color: Colors.red,
                  child: SizedBox(
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '1,429',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Total points',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                Expanded(
                    child: Card(
                  color: Colors.red,
                  child: SizedBox(
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '19km',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Total distance',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileEdit(user: currentUser),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 15)
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.edit_attributes),
                      const Gap(10),
                      Text(
                        'Edit Profile',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
              child: GestureDetector(
                onTap: () => showPasswordDialog(context),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 15)
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.edit_attributes),
                      const Gap(10),
                      Text(
                        'Change Password',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
              child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 15)
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.settings),
                      const Gap(10),
                      Text(
                        'Preferences',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  auth.signOut();
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 15)
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      const Gap(10),
                      Text(
                        'Sign out',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
