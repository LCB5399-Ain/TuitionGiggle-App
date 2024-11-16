import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/FadeAnimation.dart';
import '../../gethelper/getHelper.dart';

class TeacherTask extends StatefulWidget {
  final String tuitionID;
  final String classID;

  TeacherTask({required this.tuitionID, required this.classID});

  @override
  _TeacherTaskState createState() => _TeacherTaskState();

}

class _TeacherTaskState extends State<TeacherTask> {

  // Validate the form with form key
  // Code adapted from Arora, 2024
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController subjectControl = new TextEditingController();
  TextEditingController taskControl = new TextEditingController();
  // End of adapted code

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(116, 164, 199, 1)
            ),
            // Code adapted from Yassein, 2020
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),

                        FadeAnimation(
                          1.3,
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
                                "Add Task",
                                style: GoogleFonts.antic(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  fontSize: 40,
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
                                    FadeAnimation(1.2,
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
                                        // Add Task form
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
                                                controller: subjectControl,
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
                                                // Title validation
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Title is required';
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
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey.shade200
                                                      )
                                                  )
                                              ),

                                              child: TextFormField(
                                                controller: taskControl,
                                                decoration: InputDecoration(
                                                    labelText: "Enter Description",
                                                    hintStyle: TextStyle(color: Colors.grey,
                                                      fontSize: 22,
                                                    ),
                                                    border: InputBorder.none
                                                ),
                                                // Task validation
                                                validator: (value) {
                                                  if (value == null || value.length < 10) {
                                                    return 'Please provide a task description with at least 10 characters.';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            FadeAnimation(1.4,
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
                                                          "Send",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18
                                                          ),
                                                        ),
                                                        // Validate and submit task using GetHelper
                                                        onPressed: () {
                                                          GetHelper.submitTask(_formKey, context, widget.tuitionID, widget.classID, subjectControl.text, taskControl.text);
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