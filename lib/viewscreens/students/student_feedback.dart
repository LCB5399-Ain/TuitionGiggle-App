import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/FadeAnimation.dart';
import '../../gethelper/getHelper.dart';
import '../../widget-components/student/feedback_widget.dart';


class StudentFeedback extends StatefulWidget {
  final String studentID;

  StudentFeedback({required this.studentID});

  @override
  _StudentFeedbackState createState() => _StudentFeedbackState();

}
// Handles the class data fetching and UI updates
class _StudentFeedbackState extends State<StudentFeedback>{
  // variable to hold other feedback data.
  var feedback;

  @override
  void initState() {
    // Use the getHelper to get the feedback data
    feedback = GetHelper.getData(widget.studentID, 'get_student_feedback', 'studentID');
    super.initState();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
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
                        SizedBox(width: 70),
                        Text(
                          "Feedback",
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
            // List of feedback
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(90),
                      topRight: Radius.circular(90))
                ),
                padding: EdgeInsets.all(20),

                  // Use list view to show data
                child: FutureBuilder(future: feedback, builder: (context, snapshots) {
                  // Loads the data
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // Handles the null values there is no feedback data or is empty
                  if (!snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                    return Center(
                      child: Text('There are no feedback currently',
                          style: GoogleFonts.antic(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                          ))
                      );
                    }

                  // Extract the feedback list from the data
                  var feedbackList = snapshots.data as List;

                  return ListView.builder(
                    // Items in the list
                    itemCount: (snapshots.data as List).length,
                    itemBuilder: (context, index) {
                      // Use widget to display each feedback
                      return FeedbackWidget(
                        subject: feedbackList[index]['subject'],
                        feedback: feedbackList[index]['feedback'],
                        teacherName: feedbackList[index]['teacherName'],
                        dateOfFeedback: feedbackList[index]['date_of_feedback']
                      );
                    },
                  );
              },
              )
            ),
            ),
          ],
          // End of adapted code
        ),
      ),
    );
  }

}


