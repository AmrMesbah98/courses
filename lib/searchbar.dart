import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onetry/getdata.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name = "";

  Future<QuerySnapshot>? postDocuments;

  initSearchPost(String textEntered) {
    postDocuments = FirebaseFirestore.instance
        .collection("Data")
        .where("firstName", isGreaterThanOrEqualTo: textEntered)
        .get();
    setState(() {
      postDocuments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink, Colors.deepOrangeAccent.shade400])),
        ),
        title: TextField(
          decoration:  InputDecoration(
              hintText: "search here",
              suffixIcon: IconButton(onPressed: (){
                initSearchPost(name);
              }, icon: const Icon(Icons.search))

          ),
          onChanged: (textEntered) {
            setState(() {
              name = textEntered;
            });
            initSearchPost(textEntered);
          },
        ),
      ),
    );
  }
}
