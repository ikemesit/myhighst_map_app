import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myhighst_map_app/features/authentication/data/auth.dart';
import 'package:myhighst_map_app/features/profile/profile_edit.dart';
import 'package:myhighst_map_app/services/auth/user.service.dart';

import '../../models/user.model.dart' as model;
import '../../screens/home/home_screen.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({
    Key? key,
    required this.authUser,
  }) : super(key: key);

  final User authUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    final Future<model.User?> userQuery =
        ref.watch(userServiceProvider).getUserById(authUser.uid);

    return FutureBuilder(
        future: userQuery,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            final user = snapshot.data as model.User;

            return Scaffold(
              backgroundColor: Colors.blueGrey[50],
              appBar: AppBar(
                title: const Text(
                  'My profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                automaticallyImplyLeading: true,
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.grey,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: user.photoUrl!.isNotEmpty
                                      ? Image.network(
                                          user.photoUrl as String,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fitWidth,
                                        )
                                      : const Icon(
                                          Icons.person,
                                          size: 100,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              snapshot.data?.fullName ?? '',
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileEdit()),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 15)
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.edit_attributes),
                            Gap(10),
                            Text(
                              'Edit Profile',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 8.0),
                    child: GestureDetector(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 15)
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.settings),
                            Gap(10),
                            Text(
                              'Preferences',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 8.0),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 15)
                          ],
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.logout),
                            Gap(10),
                            Text(
                              'Sign out',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError == true) {
            return const Placeholder();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Profile Edit'),
              ),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
        });
  }
}
