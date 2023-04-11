import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhighst_map_app/common_widgets/app_text_form_field.dart';
import 'package:myhighst_map_app/services/auth/user.service.dart';
import 'package:path/path.dart';

import '../../models/user.model.dart' as model;

class ProfileEdit extends ConsumerStatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends ConsumerState<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    final User? currentUser = ref.watch(firebaseUserProvider);
    final Future<model.User?> snapshot =
        ref.watch(userServiceProvider).getUserById(currentUser?.uid);
    // final photo = ref.watch(pickedImageProvider);
    final ImagePicker picker = ImagePicker();
    String? photoUrl;
    File? photo;

    Future uploadFile() async {
      if (photo == null) return;
      final fileName = basename(photo!.path);
      const destination = 'profilePics/';

      try {
        final ref = FirebaseStorage.instance.ref(destination).child(fileName);
        final uploadTask = await ref.putFile(photo!);
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .doc('users/${currentUser?.uid}')
            .update({
          'photoUrl': downloadUrl,
        });
      } catch (e) {
        print('error occured');
      }
    }

    Future imgFromGallery() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          photo = File(pickedFile.path);
          print(photo!.path);
          uploadFile();
        } else {
          print('No image selected.');
        }
      });
    }

    Future imgFromCamera() async {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          photo = File(pickedFile.path);
          print(photo!.path);
          uploadFile();
        } else {
          print('No image selected.');
        }
      });
    }

    void showPicker(context) {
      showModalBottomSheet(
          context: context,
          useSafeArea: true,
          backgroundColor: Colors.white,
          builder: (BuildContext bc) {
            return Column(
              children: [
                const Gap(40),
                const Text(
                  'Choose Profile Picture',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            imgFromCamera();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_camera,
                                  color: Colors.white,
                                ),
                                Gap(10),
                                Text(
                                  'Camera',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            imgFromGallery();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_library,
                                  color: Colors.white,
                                ),
                                Gap(10),
                                Text(
                                  'Gallery',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    }

    return FutureBuilder(
        future: snapshot,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return Scaffold(
              backgroundColor: Colors.blueGrey[50],
              appBar: AppBar(
                title: const Text('Profile Edit'),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.grey,
                            child: photo != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      photo!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      snapshot.data!.photoUrl as String,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  )),
                      ),
                      const Gap(10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          showPicker(context);
                        },
                        child: const Text(
                          'Change Profile Photo',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Gap(30),
                      const AppTextFormField(hintText: 'First Name'),
                      const Gap(10),
                      const AppTextFormField(hintText: 'Middle Name'),
                      const Gap(10),
                      const AppTextFormField(hintText: 'Last Name'),
                    ],
                  ),
                ),
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
