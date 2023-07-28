import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _mAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              decoration: InputDecoration(
                label: Text("firstName"),
                hintText: "Enter your Name",
                suffixIcon: Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
              ),
              controller: firstname,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                label: Text("lastName"),
                hintText: "Enter your Name",
                suffixIcon: Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
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
                label: Text("email"),
                hintText: "Enter your Name",
                suffixIcon: Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
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
                suffixIcon: Icon(Icons.phone),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
              ),
              controller: phone,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                label: Text("address"),
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
                  saveUserDataInFireStore(
                    firstname.text,
                    lastname.text,
                    email.text,
                    phone.text,
                    address.text,
                  );
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

  void saveUserDataInFireStore(String firstname, String lastName, String email,
      String phone, String address) {
    data = UserDate(
        firstName: firstname,
        lastName: lastName,
        email: email,
        phone: phone,
        address: address);

    _firestore
        .collection('Data')
        .doc(_mAuth.currentUser!.uid)
        .set(data!.toJson())
        .then((value) => print("Done"));
  }
}
