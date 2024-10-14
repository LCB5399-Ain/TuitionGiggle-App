import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/FadeAnimation.dart';
import 'package:tuitiongiggle/gethelper/getHelper.dart';
import 'package:tuitiongiggle/viewscreens/students/student_task.dart';
import '../../widget-components/student/class_widget.dart';


class StudentClass extends StatefulWidget {
  final String studentID;

  StudentClass({required this.studentID});


  @override
  _StudentClassState createState() => _StudentClassState();

}

class _StudentClassState extends State<StudentClass> {

  var classes;

  @override
  void initState() {
    classes = GetHelper.getData(widget.studentID, 'get_student_class', 'studentID');
    super.initState();
  }

  // SHOW TASK Button
  _navigateTaskPage(String? classID) {
    // Check if classID (TaskID) is null before proceeding
    if (classID != null && classID.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Task(classID: classID)),
      );
    } else {
      // Show an alert or fallback action if TaskID is null or empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("TaskID is missing or invalid."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromRGBO(116, 164, 199, 1)
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
                    height: 40),
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
                    SizedBox(width: 90),
                      Text(
                        "Class",
                        style: GoogleFonts.antic(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
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
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(100))
              ),
              padding: EdgeInsets.all(20),

                // Use list view to show data
                child: FutureBuilder(future: classes,
                  builder: (context, snapshots) {
                    // Loads the data
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // Display the message if there is no data
                    if (!snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                      return Center(
                          child: Text('You have no classes right now',
                              style: GoogleFonts.antic(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                              )
                          )
                      );
                    }
                    // Use snapshots.data as list
                    var classList = snapshots.data as List;

                    return ListView.builder(
                      itemCount: classList.length,
                      itemBuilder: (context, index) {

                        return ClassWidget(
                          classroom: classList[index]['classroom'] ?? 'No Classroom',
                          subject: classList[index]['subject'] ?? 'No Subject',
                          time: classList[index]['time_of_room'] ?? 'No Time',
                          function: () =>
                              _navigateTaskPage(classList[index]['classID']),
                        );
                      },
                    );
                  },
                )),

          ),
          ],
        ),
        ),
    );
  }
}