import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/AnimationWidget.dart';
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
  late Future<List> feedback;

  // Fetch feedback data
  Future<List> _fetchFeedbackData() async {
    try {
      var response = await GetHelper.fetchData(widget.studentID, 'get_student_feedback', 'studentID');
      return response;
    } catch (e) {
      throw Exception('An error fetching the feedback data: $e');
    }
  }

  @override
  void initState() {
    feedback = _fetchFeedbackData();
    super.initState();

    // Print the response from php website
    feedback.then((response) {
      print("Raw Response: $response");
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Code adapted from Yassein, 2020
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
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
                        SizedBox(width: 70),
                        Text(
                          "Feedback",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
                padding: EdgeInsets.all(18),

                  // Use list view to show data
                  // Code adapted from SilasPaes, 2019
                child: FutureBuilder(future: feedback, builder: (context, snapshots) {
                  // Loads the data
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    // End of adapted code
                  }
                  // Handles the null values there is no feedback data or is empty
                  if (!snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                    return Center(
                      child: Text('There are no feedback currently',
                          style: GoogleFonts.lato(
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
                        titleSubject: feedbackList[index]['subject'],
                        feedback: feedbackList[index]['feedback'],
                        teacherFullName: feedbackList[index]['teacherName'],
                        feedbackDate: feedbackList[index]['date_of_feedback']
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


