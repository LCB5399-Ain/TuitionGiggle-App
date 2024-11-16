import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/FadeAnimation.dart';

class FeedbackWidget extends StatelessWidget {
  final String subject;
  final String feedback;
  final String teacherName;
  final String dateOfFeedback;

  FeedbackWidget({this.subject="", this.feedback="", this.teacherName="", this.dateOfFeedback=""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white, // Box background color
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: Container(
              width: 60,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/feedback_icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            title: Text(subject,
              style: GoogleFonts.antic(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Teacher: $teacherName',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  dateOfFeedback,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
            // Code adapted from Yassein, 2020
            onTap:() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FadeAnimation(1.5, AlertDialog(
                        title: Center(child: Text(subject)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        content: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                              Divider(thickness: 1.5,),
                              SizedBox(height: 10,),
                              // End of adapted code

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.feedback, color: Color.fromRGBO(116, 164, 199, 1)), // Feedback icon
                                  SizedBox(width: 5),
                                  Flexible(
                                    child:
                                    Text(
                                      'Feedback: $feedback',
                                       style: GoogleFonts.antic(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(height: 20),

                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.person, color: Color.fromRGBO(116, 164, 199, 1)),
                                    SizedBox(width: 6),
                                    Text(
                                      'Teacher: $teacherName',
                                      style: GoogleFonts.antic(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(thickness: 1.5,),
                              SizedBox(height: 10,),

                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.access_time, color: Color.fromRGBO(116, 164, 199, 1)),
                                    SizedBox(width: 6),
                                    Text(
                                      dateOfFeedback,
                                      style: GoogleFonts.antic(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(thickness: 1.5,),
                              SizedBox(height: 10,),

                            ],
                            ),
                          ),
                        ),
                      actions: [
                        TextButton(
                        child:
                            Text(
                              'Close',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(116, 164, 199, 1),
                              ),
                            ),

                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    );
                  },
              );
            },
          ),
        ),
      ],
    );
  }
}