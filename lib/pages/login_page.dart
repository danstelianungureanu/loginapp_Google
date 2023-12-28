// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/components/my_button.dart';
import 'package:loginapp/components/my_textfields.dart';
import 'package:loginapp/components/square_tile.dart';
import 'package:loginapp/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
// try sign in

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);

      // user from firebase
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message

      showErrorMessage(e.code);
      //
      print(e.code);

      // invalid email address

      // no user tipped in

      // no password tipped in

      // Wrong email
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.black,
                ),
                const SizedBox(height: 30),

                Text(
                  'Welcome back you\'ve been missed',
                  style: TextStyle(color: Colors.grey[700]),
                ),

                // welcome back, you've been missed !

                // user name - text field
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                // password - pass field
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                // forgot password
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password ?',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                // sing in button

                const SizedBox(height: 25),
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                ),

                // or continue with

                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // google + apple sing in buttons

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button

                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google.png'),
                    const SizedBox(width: 25),
                    // apple button
                    SquareTile(onTap: () {}, imagePath: 'lib/images/apple.png'),
                    const SizedBox(width: 10),
                  ],
                ),
                // not a  member? register now

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 4),
                      Text(
                        'Not a Member ?  ',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          ' Register Now ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
