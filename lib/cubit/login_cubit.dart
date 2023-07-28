import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../homepage.dart';
import '../login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  buildLoginFunction(String email, String password, BuildContext context) async
       {
         try{
           emit(LoginLoading());
           UserCredential userCredential = await FirebaseAuth.instance
               .signInWithEmailAndPassword(email: email, password: password);
           if(userCredential != null)
           {
             Navigator.push(context, MaterialPageRoute(builder: (_){
               return HomePage();
             }));
             emit(LoginSuccessHomePage());
           }
           else
           {
             Navigator.push(context, MaterialPageRoute(builder: (_){
               return Login();
             }));
           }
           emit(LoginSuccessLogin());
         }
           on FirebaseAuthException catch(error)
         {
           print(error);
           print(error.message);
           print(error.code);
           emit(LoginError());
         }


  }
}
