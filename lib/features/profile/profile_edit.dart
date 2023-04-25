import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhighst_map_app/common_widgets/app_text_form_field.dart';
import 'package:myhighst_map_app/services/auth/user.service.dart';
import 'package:path/path.dart';

import '../../global_states.dart';
import '../../models/user.model.dart' as model;

class ProfileEdit extends ConsumerStatefulWidget {
  const ProfileEdit({Key? key, required this.user}) : super(key: key);

  final model.User user;

  @override
  ConsumerState<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends ConsumerState<ProfileEdit> {
  String? _photoUrl;
  File? _photo;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _photoUrl = widget.user.photoUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = ref.watch(firebaseUserProvider);
    final Future<model.User?> snapshot =
        ref.watch(userServiceProvider).getUserById(currentUser?.uid);
    final ImagePicker picker = ImagePicker();

    closeDialog(BuildContext context) {
      Navigator.of(context).pop();
    }

    Future uploadFile() async {
      if (_photo == null) return;
      final fileName = basename(_photo!.path);
      const destination = 'profilePics/';

      try {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
        );

        final firebaseRef =
            FirebaseStorage.instance.ref(destination).child(fileName);
        final uploadTask = await firebaseRef.putFile(_photo!);
        final downloadUrl = await uploadTask.ref.getDownloadURL();

        setState(() {
          _photoUrl = downloadUrl;
        });

        FirebaseFirestore.instance.doc('users/${widget.user.uid}').update({
          'photoUrl': downloadUrl,
        }).then((value) {
          snapshot.then((value) =>
              ref.read(currentUserProvider.notifier).state = model.User.update(
                  value?.firstName,
                  value?.lastName,
                  value?.email,
                  value?.uid,
                  downloadUrl,
                  value?.createdAt));

          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Profile picture changed!",
            backgroundColor: Colors.white,
          ).then(
            (value) => closeDialog(context),
          );
        });
      } catch (e) {
        print('error occured');
      }
    }

    Future imgFromGallery() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _photo = File(pickedFile.path);
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
          _photo = File(pickedFile.path);
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

    saveProfileEdit() {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;

      if (firstName.isEmpty || lastName.isEmpty) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Please fill in all fields!",
          backgroundColor: Colors.white,
        );
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
        );

        FirebaseFirestore.instance.doc('users/${widget.user.uid}').update({
          'firstName': firstName,
          'lastName': lastName,
        }).then((value) {
          snapshot.then((value) =>
              ref.read(currentUserProvider.notifier).state = model.User.update(
                  firstName,
                  lastName,
                  value?.email,
                  value?.uid,
                  value?.photoUrl,
                  value?.createdAt));

          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Profile updated!",
            backgroundColor: Colors.white,
          ).then(
            (value) => closeDialog(context),
          );
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Edit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _photoUrl != null
                  ? GFAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(_photoUrl as String),
                    )
                  : GFAvatar(
                      backgroundImage:
                          NetworkImage(widget.user.photoUrl as String),
                      radius: 60,
                    ),
              const Gap(10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                  ),
                  onPressed: () {
                    showPicker(context);
                  },
                  child: const Text(
                    "Change Profile Photo",
                  )),
              const Gap(30),
              AppTextFormField(
                hintText: 'First Name',
                controller: _firstNameController,
              ),
              const Gap(10),
              AppTextFormField(
                hintText: 'Last Name',
                controller: _lastNameController,
              ),
              const Gap(40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  minimumSize: const Size.fromHeight(60),
                ),
                onPressed: saveProfileEdit,
                child: const Text(
                  'Save',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
