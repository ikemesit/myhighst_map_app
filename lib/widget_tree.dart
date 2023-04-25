// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:myhighst_map_app/features/authentication/data/auth.dart';
// import 'package:myhighst_map_app/screens/bottom_bar.dart';
//
// import 'features/authentication/presentation/login/login_screen.dart';
//
// class WidgetTree extends StatefulWidget {
//   const WidgetTree({Key? key}) : super(key: key);
//
//   @override
//   State<WidgetTree> createState() => _WidgetTreeState();
// }
//
// class _WidgetTreeState extends State<WidgetTree> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Auth().authStateChanges,
//       builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.hasData) {
//           return const BottomBar();
//         } else {
//           return LoginScreen();
//         }
//       },
//     );
//   }
// }
