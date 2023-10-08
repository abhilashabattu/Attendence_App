
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'Mark.dart';

class Test extends StatelessWidget {
  //const Test({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();

  var ID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40,),
          Center(child: TextField(controller: name,decoration: InputDecoration( hintText: "Name"),)),
          Center(child: TextField(controller: email,decoration: InputDecoration( hintText: "Email"),)),
          Center(child: TextField(controller: pass ,decoration: InputDecoration( hintText: "password"),)),
          Center(
            child: ElevatedButton(
              onPressed:()async{
                String Name = name.text.trim();
                String Email = email.text.trim();
                String password = pass.text.trim();

                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.text, password: pass.text).then((value)=> {
                      print(email)}

                );

                QuerySnapshot snap = await FirebaseFirestore.instance.collection(
                    "Table").get();
                var a = snap.docs[0]['Password'];
                print("hello");
                print(snap.docs[1]['Name']);
                print(snap.docs[1]['CollegeID']);
                print(a);
                print(snap.docs[0]['Name']);
                print(snap.docs[0]['CollegeID']);
                var ID = snap.docs[1]['CollegeID'];
                print(ID);


                /*var document = await FirebaseFirestore.instance.collection('Table').document('Name');
                document.get() => then((value) {
                print(document("name"));
                });*/

              } ,
              child: Text("press") ,
            ),
          ),
        ],
      ),
    );
  }
}
