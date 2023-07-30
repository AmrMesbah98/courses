import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StreamData extends StatelessWidget {
  const StreamData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Data").snapshots() ,
                  builder: (context, snapShot)
                {
                  if(!snapShot.hasData)
                    {
                      return Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        child: const Text(
                          'Shimmer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      );



                    }

                  var information = snapShot.data!.docs;


                  return SizedBox(
                    width: double.infinity,
                    height: 700,
                    child: ListView.builder(
                    itemCount: information.length,
                    itemBuilder: (context, index)
                        {
                          return CustomWidgetGetData(
                              firstName: information[index].get("firstName"),
                              lastName: information[index].get("lastName"),
                              email: information[index].get("email"),
                              phone: information[index].get("phone"),
                              address: information[index].get("address")
                          );
                        }
                    ),
                  );

                },
              )

            ],
          ),
        ),
      ),
    );
  }
}


class CustomWidgetGetData extends StatelessWidget {
  const CustomWidgetGetData({super.key, required this.firstName, required this.lastName, required this.email, required this.phone, required this.address});


  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(firstName, style: TextStyle(fontSize: 50, color: Colors.red),),
        Text(lastName),
        Text(email),
        Text(phone),
        Text(address)
      ],
    );
  }
}







