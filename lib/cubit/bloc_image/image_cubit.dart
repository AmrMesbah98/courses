import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../appuser.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  static ImageCubit get(context) => BlocProvider.of(context);

  Future<String?> uploadImage() async {
    try {
      emit(UploadImageLoading());
      var picker = ImagePicker();
      XFile? xFile = await picker.pickImage(source: ImageSource.camera);
      emit(UploadImageSuccess());
      return xFile?.path;
    } catch (e) {
      print(e);
      emit(UploadImageError());
    }
  }

  String downloadUrl = "";

  Future<void> saveImage() async {
    try {
      emit(SaveImageLoading());

      String? path = await uploadImage();

      String suffix = DateTime.now().second.toString();
      emit(SaveImageSuccessTime());
      File file = File(path!);

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child("image")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child("${FirebaseAuth.instance..currentUser!.uid}$suffix")
          .putFile(file);

      emit(SaveImageSuccessUploadTask());

      task.whenComplete(() async {
        downloadUrl = await task.snapshot.ref.getDownloadURL();
        saveImageInFireStore(downloadUrl);
        emit(SaveImageSuccess());
      });
    } catch (e) {
      print(e);
      emit(SaveImageError());
    }
  }

  UserDate? data;

  saveImageInFireStore(String downloadUrl) {
    try {
      emit(LinkLoadingFireStore());
      if (data != null) {
        data?.pic = downloadUrl;
        FirebaseFirestore.instance
            .collection("Data")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(data!.toJson());
        emit(LinkSuccessFireStore());
      }
    } catch (e) {
      print(e);
      emit(LinkErrorFireStore());
    }
  }
}
