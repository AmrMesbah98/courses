import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/bloc_image/image_cubit.dart';
import 'cubit/get_firestore_cubit.dart';
import 'cubit/login_cubit.dart';
import 'login.dart';
import 'observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ImageCubit()..saveImage()),
        BlocProvider(create: (context) => GetFirestoreCubit()..getUserDataFromFireStore()),
      ],
      child: MaterialApp(
        home: Login(),
      ),
    );
  }
}


