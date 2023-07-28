import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../appuser.dart';

part 'get_firestore_state.dart';

class GetFirestoreCubit extends Cubit<GetFirestoreState> {
  GetFirestoreCubit() : super(GetFirestoreInitial());

  UserDate? getData;

  static GetFirestoreCubit get(context) => BlocProvider.of(context);

  Future<void> getUserDataFromFireStore() async {
    try {
      emit(GetFirestoreLoading());
     await FirebaseFirestore.instance
          .collection("Data")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((DocumentSnapshot value) {
        print(value);
        print(value.data());
        print(value.data().runtimeType);

        Map<String, dynamic> result =
            Map.from(value.data() as Map<String, dynamic>);

        getData = UserDate.fromJson(result);

        emit(GetFirestoreSuccess());
      });
    } on FirebaseException catch (error) {
      print(error);
      print(error.code);
      print(error.message);
      emit(GetFirestoreError());
    }
  }
}
