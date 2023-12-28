import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:flutter/material.dart';
import 'package:loginapp/pages/login_Or_Register_Page.dart';
import 'package:loginapp/pages/home_page.dart' show HomePage;

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // is the user logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          // is the user NOT logged in

          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
