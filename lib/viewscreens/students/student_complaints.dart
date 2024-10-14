import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/FadeAnimation.dart';
import 'package:tuitiongiggle/gethelper/getHelper.dart';

class StudentComplaints extends StatefulWidget {
  final String tuitionID;

  StudentComplaints({required this.tuitionID});

  @override
  _StudentComplaintsState createState() => _StudentComplaintsState();

}

class _StudentComplaintsState extends State<StudentComplaints> {

  // Form Key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController roleControl = new TextEditingController();
  TextEditingController fullNameControl = new TextEditingController();
  TextEditingController phoneNumberControl = new TextEditingController();
  TextEditingController titleControl = new TextEditingController();
  TextEditingController feedbackControl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.tuitionID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(116, 164, 199, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),

                    FadeAnimation(
                      1.3,
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: Colors.white,
                                size: 30
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 60),
                          Text(
                            "Complaint",
                            style: GoogleFonts.antic(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                    topRight: Radius.circular(90)
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      FadeAnimation(1.4,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(116, 164, 199, 1),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                                )
                              ]
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200
                                      )
                                    )
                                  ),
                                  child: TextFormField(
                                    controller: roleControl,
                                    decoration: InputDecoration(
                                      labelText: "Relationship",
                                      hintStyle: TextStyle(color: Colors.grey,
                                      fontSize: 22,
                                      ),
                                      border: InputBorder.none
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'State your relationship';
                                      } else {
                                        return null;
                                      }
                                    }, // Relationship validation
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200
                                          )
                                      )
                                  ),

                                  child: TextFormField(
                                    controller: fullNameControl,
                                    decoration: InputDecoration(
                                        labelText: "Name",
                                        hintStyle: TextStyle(color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Name is required';
                                      } else if (!RegExp(r"^[a-zA-Z\s']+$").hasMatch(value!)) {
                                        return 'Enter a valid name';
                                      }
                                        return null;
                                    }, // Name validation
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200
                                          )
                                      )
                                  ),

                                  child: TextFormField(
                                    controller: phoneNumberControl,
                                    // Display the number keyboard
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        labelText: "Phone Number",
                                        hintStyle: TextStyle(color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Phone number is required';
                                      } else if (!RegExp(r'^\+?([0-9]{1,3})?[-.●]?([0-9]{10})$').hasMatch(value!)) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    }, // Phone number validation
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200
                                          )
                                      )
                                  ),

                                  child: TextFormField(
                                    controller: titleControl,
                                    decoration: InputDecoration(
                                        labelText: "Title",
                                        hintStyle: TextStyle(color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Title is required';
                                      } else if (!RegExp(r"^[a-zA-Z\s']+$").hasMatch(value!)) {
                                        return 'Enter a valid name';
                                      }
                                        return null;
                                    }, // Title validation
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200
                                          )
                                      )
                                  ),

                                  child: TextFormField(
                                    controller: feedbackControl,
                                    decoration: InputDecoration(
                                        labelText: "Enter your complaints",
                                        hintStyle: TextStyle(color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 20) {
                                        return 'Your message should contain at least 20 characters.';
                                      } else {
                                        return null;
                                      }
                                    }, // Complaint validation
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                FadeAnimation(1.6,
                                    Container(
                                      height: 50,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 50
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color.fromRGBO(116, 164, 199, 1)
                                      ),

                                      child: Center(
                                        child: TextButton(
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          // Button to submit complaints using GetHelper
                                          onPressed: () {
                                            GetHelper.submitComplaints(_formKey, context, roleControl.text, fullNameControl.text, phoneNumberControl.text, titleControl.text, feedbackControl.text, widget.tuitionID);
                                          }
                                        ),
                                      ),
                                    )
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ]
                              ),
                            ),
                          ),
                      ),
                    ])
                  )
                )
              )
            )
        ]
        )
      )
    );
  }

}