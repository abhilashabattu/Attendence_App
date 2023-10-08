
import 'package:attendence/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'Register.dart';
import 'test.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home : SplashScreen(),
      debugShowCheckedModeBanner: false,
    );

  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("WELCOME" ,),
      toolbarHeight: 70,
        shadowColor: Colors.black,
        backgroundColor: Colors.cyan.shade700,
      ),
      body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
            //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Padding(
                 padding: const EdgeInsets.only( top: 70.0, left: 120.0),
                 child:
                 Icon(Icons.account_box , size: 150, color: Colors.black,),),
                Padding(
                  padding: const EdgeInsets.only(left: 120.0),
                  child: TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                     child:Text("LOGIN" ,
                         style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color:Colors.black ),),
                     ),
                ),

                SizedBox(height: 60,),
                Padding( padding: const EdgeInsets.only(top: 50.0, left: 120.0),
                     child: Icon(Icons.how_to_reg , size: 150, color: Colors.black,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 110.0),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                  },
                      child: Text("REGISTER" ,
                        style: TextStyle(fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold ),)),
                )

              ],
            ),
    );
  }
}

