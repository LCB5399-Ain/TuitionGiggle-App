import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/AnimationWidget.dart';
import 'package:tuitiongiggle/gethelper/getHelper.dart';
import 'package:tuitiongiggle/viewscreens/students/student_task.dart';
import '../../widget-components/student/class_widget.dart';


class StudentClass extends StatefulWidget {
  final String studentID;

  StudentClass({required this.studentID});


  @override
  _StudentClassState createState() => _StudentClassState();

}
// Handles the class data fetching and UI updates
class _StudentClassState extends State<StudentClass> {
  // Class variable to hold other class data.
  late Future<List> classes;

  // Fetch class data
  Future<List> _fetchClassData() async {
    try {
      var response = await GetHelper.fetchData(widget.studentID, 'get_student_class', 'studentID');
      return response;
    } catch (e) {
      throw Exception('There is an error fetching class data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Get the future class data
    classes = _fetchClassData();
  }

  // Navigate students to the 'Show Task' page
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
                    height: 40),
                  WidgetFadeAnimation(
                    1.2,
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
                    SizedBox(width: 90),
                      Text(
                        "Class",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
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
            // List of classes
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
                child: FutureBuilder(future: classes,
                  builder: (context, snapshots) {
                    // Loads the data
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      // End of adapted code
                    }
                    // Handles the null values there is no class data or is empty
                    if (!snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                      return Center(
                          child: Text('You have no classes right now',
                              style: GoogleFonts.lato(
                                  fontSize: 30
                              )
                          )
                      );
                    }
                    // Extract the class list from the data
                    var classList = snapshots.data as List;

                    return ListView.builder(
                      // Items in the list
                      itemCount: classList.length,
                      itemBuilder: (context, index) {
                        // Use widget to display each class
                        return ClassWidget(
                          classroom: classList[index]['classroom'] ?? 'No Classroom',
                          subject: classList[index]['subject'] ?? 'No Subject',
                          classTime: classList[index]['time_of_room'] ?? 'No Time',
                          // Pass the classID to the task page
                          voidFunction: () =>
                              _navigateTaskPage(classList[index]['classID']),
                        );
                      },
                    );
                  },
                )),

          ),
          ],
          // End of adapted code
        ),
        ),
    );
  }
}