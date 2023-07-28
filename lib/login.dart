import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homepage.dart';
import 'cubit/login_cubit.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> onekey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return MaterialApp(
            home: Scaffold(
          appBar: AppBar(
            title: const Text("Bloc & fireBase"),
          ),
          body: Form(
            key: onekey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    labelStyle: TextStyle(fontSize: 20),
                    prefixIcon: Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue), //<-- SEE HERE
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null) {
                      return 'you must enter email';
                    }
                  },
                  controller: emailController,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    labelStyle: TextStyle(fontSize: 20),
                    prefixIcon: Icon(Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black), //<-- SEE HERE
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue), //<-- SEE HERE
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null) {
                      return 'you must enter Password';
                    }
                  },
                  controller: passwordController,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      if (onekey.currentState!.validate()) {
                        LoginCubit.get(context).buildLoginFunction(
                            emailController.text,
                            passwordController.text,
                            context);
                      }
                    },
                    child: const Text("LOGIN"))
              ],
            ),
          ),
        ));
      },
    );
  }

  buildSignInFunction(BuildContext context, String email, String pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      if (userCredential != null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return HomePage();
        }));
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      print(error.message);
      print(error.code);
    }
  }
}
