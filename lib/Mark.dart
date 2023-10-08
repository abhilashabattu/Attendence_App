import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'loginPage.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'test.dart';


class Mark extends StatefulWidget {
  @override
  State<Mark> createState() => _MarkState();
}

class _MarkState extends State<Mark> {
  //const Mark({super.key});
  double screenHeight = 0;
  double screenWidth = 0;

  String CheckIn = "--##--";
  String CheckOut = "--##--";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecord();
  }

  void getRecord()async{
    try{
      QuerySnapshot snap = await FirebaseFirestore
          .instance.collection("Table").where('id' , isEqualTo: Test().ID).get();

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("Table")
          .doc(snap.docs[1].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now())).get();


      setState(() {
        CheckIn = documentSnapshot['checkIn'];
            CheckOut = documentSnapshot['checkOut'];
      });

    }catch(e){

      setState(() {
        CheckIn = "--##--";
        CheckOut = "--##--";
      });
    }
    print(CheckIn);
    print(CheckOut);

  }

  @override
  Widget build(BuildContext context) {


    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    Color primary = Colors.cyan.shade700;

    String formattedDate = DateFormat.yMMM().format(DateTime.now());



    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 32),
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth / 20
                        ),
                      ),
                    ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Employee",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth / 18,
                    fontFamily: "NexaBold"
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 32),
                child: Text(
                  "Today's Status",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth / 18,
                    fontFamily: "NexaBold"
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14 , bottom: 32),
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      offset: Offset(2,2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Check In",
                            style: TextStyle(
                              fontSize: screenWidth / 20,
                              color: Colors.black
                            ),
                          ),
                          Text(CheckIn ,
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                    )),
                    Expanded(child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "Check Out",
                            style: TextStyle(
                              fontSize: screenWidth / 20,
                              color: Colors.black,
                            ),
                          ),
                          Text( CheckOut,
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: DateTime.now().day.toString(),
                    style: TextStyle(
                      color: primary,
                      fontSize: screenWidth/ 18,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: ( formattedDate) ,
                  style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth / 20,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ]
                  ), // used for giving different color

                ),
              ),
              StreamBuilder(
                stream: Stream.periodic( const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: screenWidth / 20,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: 10,),
               CheckOut == "--##--" ? Container(
                child:
                       GradientSlideToAct(
                         height: 60,
                         width: 380,

                         dragableIcon: Icons.arrow_forward,
                         submittedIcon: Icons.check_circle,
                         text: CheckIn == "--##--" ? "Slide to Check In" : "Slide to Check Out",
                         textStyle: TextStyle(color: Colors.white, fontSize: 15),
                         backgroundColor: Colors.cyan.shade700,
                         onSubmit: () async {
                           Timer(Duration(seconds: 2), () {
                             var key;
                             key.currentState!.reset();
                           });
                           print(DateFormat('hh:mm').format(DateTime.now()));

                           QuerySnapshot snap = await FirebaseFirestore
                               .instance.collection("Table").where(
                               'id', isEqualTo: Test().ID).get();

                           print(snap.docs[1]['CollegeID']);
                           print(snap.docs[1].id);
                           // print(DateFormat('dd MMMM yyyy').format(DateTime.now()));

                           DocumentSnapshot documentSnapshot = await FirebaseFirestore
                               .instance
                               .collection("Table")
                               .doc(snap.docs[1].id)
                               .collection("Record")
                               .doc(DateFormat('dd MMMM yyyy').format(
                               DateTime.now())).get();

                           try {
                             String checkIn = documentSnapshot['checkIn'];

                             setState(() {
                               CheckOut =  DateFormat('hh:mm').format(
                                   DateTime.now());
                             });

                             await FirebaseFirestore.instance
                                 .collection("Table")
                                 .doc(snap.docs[1].id)
                                 .collection("Record")
                                 .doc(DateFormat('dd MMMM yyyy').format(
                                 DateTime.now()))
                                 .update({
                               'checkIn': checkIn,
                               'checkOut': DateFormat('hh:mm').format(
                                   DateTime.now()),
                             });
                           } catch (e) {

                             setState(() {
                               CheckIn = DateFormat('hh:mm').format(
                                   DateTime.now());
                             });

                             await FirebaseFirestore.instance
                                 .collection("Table")
                                 .doc(snap.docs[1].id)
                                 .collection("Record")
                                 .doc(DateFormat('dd MMMM yyyy').format(
                                 DateTime.now()))
                                 .set({
                               'checkIn': DateFormat('hh:mm').format(
                                   DateTime.now()),
                             });
                           }
                         //  getRecord();
                         },
                         gradient: const LinearGradient(
                             begin: Alignment.topLeft,
                             colors: [
                               Colors.cyan,
                               Colors.white
                             ]
                         ),
                       ),
               )
                     : Container(
                        margin: const EdgeInsets.only(top: 32) ,
                        child: Text("You have completed your day!" ,
                        style: TextStyle(
                          fontSize: screenWidth / 18,
                          color: Colors.black
                        ),
                        ),
              ),
              SizedBox(height: 10,),
           /*  ElevatedButton(onPressed: ()async{

                QuerySnapshot snap = await FirebaseFirestore
                    .instance.collection("Table").where('id' , isEqualTo: Test().ID).get();

                print(snap.docs[1]['CollegeID']);
                print(snap.docs[1].id);
                 // print(DateFormat('dd MMMM yyyy').format(DateTime.now()));

               DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                   .collection("Table")
                   .doc(snap.docs[1].id)
                   .collection("Record")
                   .doc(DateFormat('dd MMMM yyyy').format(DateTime.now())).get();

                try{
                  String checkIn = documentSnapshot['checkIn'];
                  await FirebaseFirestore.instance
                      .collection("Table")
                      .doc(snap.docs[1].id)
                      .collection("Record")
                      .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                  .update({
                    'checkIn' : checkIn,
                    'checkOut' : DateFormat('hh:mm').format(DateTime.now()),
                  });
                }catch(e){
                  print(e);
                  await FirebaseFirestore.instance
                      .collection("Table")
                      .doc(snap.docs[1].id)
                      .collection("Record")
                      .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                      .set({
                    'checkIn' : DateFormat('hh:mm').format(DateTime.now()),
                  });
                }
                getRecord();

              }, child: Text("press" ))*/


            ],
          ),
        ),
      )
    );
  }
}