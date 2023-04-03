import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhighst_map_app/services/auth/auth.dart';

import '../home/home_screen.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  File? _photo;

  // final imagePickerProvider = FutureProvider<XFile?>((ref) => null);

  final ImagePicker _picker = ImagePicker();

  // Future imgFromGallery() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _photo = File(pickedFile.path);
  //       uploadFile();
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  //
  // Future imgFromCamera() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _photo = File(pickedFile.path);
  //       uploadFile();
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  //
  // Future uploadFile() async {
  //   if (_photo == null) return;
  //   final fileName = basename(_photo!.path);
  //   const destination = 'profilePics/';
  //
  //   try {
  //     final ref = FirebaseStorage.instance.ref(destination).child(fileName);
  //     final uploadTask = await ref.putFile(_photo!);
  //   } catch (e) {
  //     print('error occured');
  //   }
  // }

  // void _showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Wrap(
  //             children: <Widget>[
  //               const SizedBox(
  //                 height: 40,
  //               ),
  //               ListTile(
  //                   leading: const Icon(Icons.photo_library),
  //                   title: const Text('Gallery'),
  //                   onTap: () {
  //                     imgFromGallery();
  //                     Navigator.of(context).pop();
  //                   }),
  //               ListTile(
  //                 leading: const Icon(Icons.photo_camera),
  //                 title: const Text('Camera'),
  //                 onTap: () {
  //                   imgFromCamera();
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: user.when(
        data: (val) => val != null
            ? Column(
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
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.grey,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: val.photoURL != null
                                      ? Image.network(
                                          val.photoURL!,
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
                              val.displayName!,
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
                        Auth().signOut();
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
              )
            : null,
        error: (_, __) => const Center(
          child: Text('An error occured!'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
