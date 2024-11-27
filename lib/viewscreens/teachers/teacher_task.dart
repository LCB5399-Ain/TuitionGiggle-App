import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/viewscreens/teachers/teacher_class.dart';
import '../../animation/AnimationWidget.dart';
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
  GlobalKey<FormState> _taskFormKey = GlobalKey<FormState>();
  TextEditingController subjectTeacherControl = new TextEditingController();
  TextEditingController taskTeacherControl = new TextEditingController();
  // End of adapted code

  @override
  void initState() {
    super.initState();
    subjectTeacherControl.addListener(() {
      // Changes in the subject field
      print('Subject input changed: ${subjectTeacherControl.text}');
    });
    taskTeacherControl.addListener(() {
      // Changes in the task field
      print('Task input changed: ${taskTeacherControl.text}');
    });
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
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
                                "Add Task",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
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
                                        // Add Task form
                                        child: Form(
                                          key: _taskFormKey,
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
                                                controller: subjectTeacherControl,
                                                decoration:  const InputDecoration(
                                                    labelText: "Title",
                                                    hintStyle: TextStyle(color: Colors.black,
                                                      fontSize: 25,
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
                                                    return 'Enter a valid title';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(12),
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
                                                controller: taskTeacherControl,
                                                decoration:  const InputDecoration(
                                                    labelText: "Enter Description",
                                                    hintStyle: TextStyle(color: Colors.black,
                                                      fontSize: 25,
                                                    ),
                                                    border: InputBorder.none
                                                ),
                                                // End of adapted code

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
                                            WidgetFadeAnimation(1.4,
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
                                                          "Send",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 18
                                                          ),
                                                        ),
                                                        // Validate and submit task using GetHelper
                                                        onPressed: () {
                                                          GetHelper.submitTask(_taskFormKey, context, widget.tuitionID, widget.classID, subjectTeacherControl.text, taskTeacherControl.text);

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