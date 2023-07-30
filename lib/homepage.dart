import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onetry/search.dart';
import 'package:onetry/searchbar.dart';

import 'appuser.dart';
import 'getdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  late FirebaseAuth _mAuth;
  late FirebaseFirestore _firestore;
  late Reference _storage;

  @override
  void initState() {
    super.initState();
    _mAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance.ref();
  }

  @override
  void dispose() {
    super.dispose();
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
  }

  UserDate? data;

  String downloadUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return  const Searchpage();
            }));
          }, icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextFormField(
              decoration: InputDecoration(
                label: const Text("firstName"),
                hintText: "Enter your Name",
                suffixIcon: const Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
              ),
              controller: firstname,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                label: const Text("lastName"),
                hintText: "Enter your Name",
                suffixIcon: const Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
              ),
              controller: lastname,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                label: const Text("email"),
                hintText: "Enter your Name",
                suffixIcon: const Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
              ),
              controller: email,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                label: Text("phone"),
                hintText: "Enter your Name",
                suffixIcon: const Icon(Icons.phone),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
              ),
              controller: phone,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                label: const Text("address"),
                hintText: "Enter your Name",
                suffixIcon: Icon(Icons.location_on),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
              ),
              controller: address,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  saveImage();
                },
                child: const Text("take photo")),
            ElevatedButton(
                onPressed: () {
                  saveUserDataInFireStore(
                    firstname.text,
                    lastname.text,
                    email.text,
                    phone.text,
                    address.text,
                    downloadUrl,
                  );
                  saveImageInFireStore(downloadUrl);
                },
                child: Text("up to firestore")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const GetDataFireStore();
                  }));
                },
                child: const Text("Get From FireStore")),
          ],
        ),
      ),
    );
  }

  // get image from camera with xfile path => image picker

  Future<String?> uploadImage() async {
    var picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    return xFile?.path;
  }

  Future<void> saveImage() async {
    String? path = await uploadImage();

    String suffix = DateTime.now().second.toString();

    File file = File(path!);

    UploadTask task = _storage
        .child("image")
        .child(_mAuth.currentUser!.uid)
        .child("${_mAuth.currentUser!.uid}$suffix")
        .putFile(file);

    task.whenComplete(() async {
      downloadUrl = await task.snapshot.ref.getDownloadURL();
      saveImageInFireStore(downloadUrl);
    });
  }

  saveImageInFireStore(String downloadUrl) {
    if (data != null) {
      data?.pic = downloadUrl;
      _firestore
          .collection("Data")
          .doc(_mAuth.currentUser!.uid)
          .set(data!.toJson());
    }
  }

  void saveUserDataInFireStore(String firstname, String lastName, String email,
      String phone, String address, String urlImage) {
    data = UserDate(
      firstName: firstname,
      lastName: lastName,
      email: email,
      phone: phone,
      address: address,
      pic: urlImage,
    );
    _firestore
        .collection('Data')
        .doc(_mAuth.currentUser!.uid)
        .set(data!.toJson())
        .then((value) => print("Done"));
  }
}
