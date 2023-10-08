import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'loginPage.dart';

class Register extends StatelessWidget {
  //const Register({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER" , style: TextStyle(fontSize: 18 ,),
        ),
        backgroundColor: Colors.cyan.shade700,toolbarHeight: 70,
      ),
      body: Center(
        child: Container(
          width: 350,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40,),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Enter your Email" ,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 3
                        ),
                        borderRadius: BorderRadius.circular(11.0)
                      ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2
                      )
                    )
                  ),

                ),
                SizedBox(height: 30,),
                TextField(
                  controller: pass,
                  decoration: InputDecoration(
                    hintText: "Enter the password",
                    border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    width: 3
                    ),
                  borderRadius: BorderRadius.circular(11.0)
                    ),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2
                    )
                    )
                  ),
                ),
                SizedBox(height: 35,),
                ElevatedButton(onPressed: () {
                 FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: pass.text)
                     .then((value) => AlertDialog(title: Text("STATUS"), content: Text("Registered successfully"),));
                },
                    child: Text("Register" , style: TextStyle(fontSize: 15),
                    ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan.shade700),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
