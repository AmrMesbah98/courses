import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onetry/stream.dart';

import 'appuser.dart';
import 'cubit/get_firestore_cubit.dart';

class GetDataFireStore extends StatefulWidget {
  const GetDataFireStore({super.key});

  @override
  State<GetDataFireStore> createState() => _GetDataFireStoreState();
}

class _GetDataFireStoreState extends State<GetDataFireStore> {
  late FirebaseAuth _mAuth;
  late FirebaseFirestore _fireStore;

  @override
  void initState() {
    super.initState();
    _mAuth = FirebaseAuth.instance;
    _fireStore = FirebaseFirestore.instance;
  }

  UserDate? getData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Get Data",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<GetFirestoreCubit, GetFirestoreState>(
        builder: (context, state) {
          if (state is GetFirestoreLoading) {
            return const Center(child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(GetFirestoreCubit.get(context).getData!.firstName),
                Text(GetFirestoreCubit.get(context).getData!.lastName),
                Text(GetFirestoreCubit.get(context).getData!.email),
                Text(GetFirestoreCubit.get(context).getData!.phone),
                Text(GetFirestoreCubit.get(context).getData!.address),


                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return const StreamData();
                  }));
                }, child: const Text("Stream Data"))
              ],
            ),
          );
        },
      ),
    );
  }
}


