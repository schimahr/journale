import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journalio/data/view_models/providers/auth_provider.dart';
import 'package:journalio/ui/views/home_view.dart';
import 'package:journalio/ui/views/auth_view.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

// class _AuthenticationWidgetState extends State<AuthenticationWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(builder: (context, providers, child) {
//       return StreamBuilder<User?>(
//         stream: providers.userStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             User? user = snapshot.data;
//             if (user == null) {
//               return SplashScreenView();
//             }
//             return HomeView();
//           } else {
//             return Scaffold(
//               body: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [
//                     Color(0xFF57837B),
//                     Color(0xFF496E67),
//                     Color(0xFF41625B),
//                     Color(0xFF314945)
//                   ], stops: [
//                     0.2,
//                     0.4,
//                     0.6,
//                     0.8
//                   ], begin: Alignment.bottomLeft, end: Alignment.topRight),
//                 ),
//                 child: Center(
//                   child: CircleIndicator(),
//                 ),
//               ),
//             );
//           }
//         },
//       );
//     });
//   }
// }

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return FutureBuilder<User?>(
          future: auth.currentUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) return HomeView();
            return AuthView();
          },
        );
      },
    );
  }
}
