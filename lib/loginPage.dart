import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendence/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Mark.dart';
import 'test.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  double screenHeight = 0;
  double screenWidth = 0;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();


  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    Color primary = Colors.cyan.shade400;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      Column(
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight / 3,
                width: screenWidth,
                decoration: BoxDecoration(
                    color: primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      )
                    ]
                ),
              ),
              Positioned(
                bottom: 100,
                left: 150,
                child: Icon(Icons.person,
                  color: Colors.white, size: screenWidth / 4.5
                  ,),
              ),

              Positioned(
                  bottom: 70,
                  left: 163,
                  child: Text("LOGIN",
                    style: TextStyle(fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),))
            ],
          ),
          SizedBox(height: 60,),
          fields("Enter your name", name, false),
          SizedBox(height: 25,),
          fields("Enter the Email", email, false),
          SizedBox(height: 25,),
          fields("Enter password", pass, true),
          SizedBox(height: 30,),
         ElevatedButton(onPressed:
            ()async{
           FocusScope.of(context).unfocus();
             String Name = name.text.trim();
             String Email = email.text.trim();
             String password = pass.text.trim();

             if(Email.isEmpty){
               print("mail empty");
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Email is not entered"),
               ));
             }
             else if(password.isEmpty){
               print("pass empty");
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                   content: Text("Password is not entered"),
               ));
             }else {
               FirebaseAuth.instance.signInWithEmailAndPassword(
                   email: email.text, password: pass.text).then((value){Navigator.push(context,
                       MaterialPageRoute(builder: (context)=> Mark()));},
               );
               QuerySnapshot snap = await FirebaseFirestore.instance.collection(
                   "Table").get();

               print( snap.docs[0]['Password']);

               try {
                 if (password == snap.docs[1]['Password'] && Email == snap.docs[1]['Email']) {
                   FirebaseAuth.instance.signInWithEmailAndPassword(
                       email: email.text, password: pass.text).then((value) =>
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) => Mark())),
                   );
                 }
                 else {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                     content: Text("Password is not correct"),
                   ));
                 }
               }catch(e){
                 ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                   content: Text(e.toString()),
                 ));
               }
             }

           },
           child: Text("Login" , style: TextStyle(
                 color: Colors.white, fontSize: 15
               ),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan.shade500
            ),
             ),
        ],
      ),
    );
  }

  Widget fields(String hint, TextEditingController controller, bool obsecure) {
    return
      Container(
        width: screenWidth / 1.3,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
          ],
        ),

        child: Row(
          children: [

            Container(
              width: screenWidth / 6,
              child: Icon(Icons.person),

            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                    horizontal: screenWidth / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint,

                ),
                maxLines: 1,
                obscureText: obsecure,
              ),
            ),
          ],
        ),
      );
  }
}

