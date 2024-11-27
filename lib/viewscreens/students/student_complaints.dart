import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/AnimationWidget.dart';
import 'package:tuitiongiggle/gethelper/getHelper.dart';

class StudentComplaints extends StatefulWidget {
  final String tuitionID;

  StudentComplaints({required this.tuitionID});

  @override
  _StudentComplaintsState createState() => _StudentComplaintsState();

}

class _StudentComplaintsState extends State<StudentComplaints> {

  // Validate the form with form key
  // Code adapted from Arora, 2024
  GlobalKey<FormState> _complaintFormKey = GlobalKey<FormState>();

  TextEditingController roleControl = new TextEditingController();
  TextEditingController fullNameControl = new TextEditingController();
  TextEditingController phoneNumberControl = new TextEditingController();
  TextEditingController titleComplaintControl = new TextEditingController();
  TextEditingController feedbackComplaintControl = new TextEditingController();
  // End of adapted code


  @override
  void initState() {
    super.initState();
    roleControl.addListener(() {
      // Changes in the role field
      print('Subject input changed: ${roleControl.text}');
    });

    fullNameControl.addListener(() {
      // Changes in the name field
      print('Task input changed: ${fullNameControl.text}');
    });

    phoneNumberControl.addListener(() {
      // Changes in the phone number field
      print('Subject input changed: ${phoneNumberControl.text}');
    });

    titleComplaintControl.addListener(() {
      // Changes in the title field
      print('Task input changed: ${titleComplaintControl.text}');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(116, 164, 199, 1),
        ),
          // Code adapted from Yassein, 2020
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),

                    WidgetFadeAnimation(
                      1.4,
                      Row(
                        children: [
                          IconButton(
                            // Back arrow button
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
                            style: GoogleFonts.lato(
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
                  padding: EdgeInsets.all(28),
                  child: SingleChildScrollView(
                    child: Column(
                        children: <Widget>[
                       const SizedBox(height: 60,
                      ),
                      WidgetFadeAnimation(1.2,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(116, 164, 199, 1),
                                  blurRadius: 18,
                                  offset: Offset(0, 13)
                                )
                              ]
                            ),
                            // Show task
                            child: Form(
                              key: _complaintFormKey,
                              child: Column(
                                  children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 0.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2), // Light shadow for a soft effect
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),

                                  // Code adapted from Algolia, 2024
                                  child: TextFormField(
                                    controller: roleControl,
                                    decoration:  const InputDecoration(
                                      labelText: "Relationship",
                                      hintStyle: TextStyle(color: Colors.grey,
                                      fontSize: 22,
                                      ),
                                      border: InputBorder.none
                                    ),
                                    // End of adapted code
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    // Relationship validation
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'State your relationship';
                                      } else if (!RegExp(r"^[a-zA-Z\s']+$").hasMatch(value!)) {
                                        return 'Enter a valid title';
                                        }
                                        return null;
                                    },
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 0.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),

                                  // Code adapted from Algolia, 2024
                                  child: TextFormField(
                                    controller: fullNameControl,
                                    decoration:  const InputDecoration(
                                        labelText: "Name",
                                        hintStyle: TextStyle(color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none
                                    ),
                                    // End of adapted code
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),

                                    // Name validation
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Name is required';
                                      } else if (!RegExp(r"^[a-zA-Z\s']+$").hasMatch(value!)) {
                                        return 'Enter a valid name';
                                      }
                                        return null;
                                    },
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 0.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),

                                  // Code adapted from Algolia, 2024
                                  child: TextFormField(
                                    controller: phoneNumberControl,
                                    // Display the number keyboard
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        labelText: "Phone Number",
                                        hintStyle: TextStyle(color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none
                                    ),
                                    // End of adapted code
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Phone number is required';
                                      } else if (!RegExp(r'^\d{7}$').hasMatch(value!)) {
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
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 0.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),

                                  // Code adapted from Algolia, 2024
                                  child: TextFormField(
                                    controller: titleComplaintControl,
                                    decoration:  const InputDecoration(
                                        labelText: "Title",
                                        hintStyle: TextStyle(color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none
                                    ),
                                    // End of adapted code
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    // Title validation
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Title is required';
                                      } else if (!RegExp(r"^[a-zA-Z\s']+$").hasMatch(value!)) {
                                        return 'Enter a valid name';
                                      }
                                        return null;
                                    },
                                  ),
                                ),

                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 0.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),

                                  // Code adapted from Algolia, 2024
                                  child: TextFormField(
                                    controller: feedbackComplaintControl,
                                    decoration: const InputDecoration(
                                        labelText: "Enter your complaints",
                                        hintStyle: TextStyle(color: Colors.grey,
                                          fontSize: 22,
                                        ),
                                        border: InputBorder.none
                                    ),
                                    // End of adapted code
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),

                                    // Complaint validation
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 20) {
                                        return 'Your message should contain at least 20 characters.';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                WidgetFadeAnimation(1.6,
                                    Container(
                                      height: 50,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 55
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(55),
                                        color: Color.fromRGBO(116, 164, 199, 1)
                                      ),

                                      child: Center(
                                        child: TextButton(
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          // // Validate and submit complaints using GetHelper
                                          onPressed: () {
                                            GetHelper.submitComplaints(_complaintFormKey, context, roleControl.text, fullNameControl.text, phoneNumberControl.text, titleComplaintControl.text, feedbackComplaintControl.text, widget.tuitionID);
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
        // End of adapted code
      )
    );
  }

}