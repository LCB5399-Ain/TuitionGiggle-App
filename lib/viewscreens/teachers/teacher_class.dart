import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/viewscreens/teachers/teacher_task.dart';
import '../../animation/FadeAnimation.dart';
import '../../gethelper/getHelper.dart';
import '../../widget-components/teacher/teacher_class_widget.dart';


class TeacherClass extends StatefulWidget {
  final String teacherID;
  final String tuitionID;

  TeacherClass({required this.teacherID, required this.tuitionID});

  @override
  _TeacherClassState createState() => _TeacherClassState();

}

// Handles the class data fetching and UI updates
class _TeacherClassState extends State<TeacherClass> {
  // Class variable to hold other class data.
  var classes;

  @override
  void initState() {
    // Use the getHelper to get the class data
    classes = GetHelper.getData(widget.teacherID, 'get_teacher_class', 'teacherID');
    super.initState();
  }

  // Navigate teachers to the 'Add Task' page
  TaskForm(String classID, String tuitionID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeacherTask (
        classID: classID,
        tuitionID: tuitionID,
      )
      ),
    );
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
                    height: 40,
                  ),

                  FadeAnimation(
                    1.3,
                    Row(
                      children: [
                        // Back arrow button
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
            // List of classes
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
                  child: FutureBuilder(future: classes,
                    builder: (context, snapshots) {
                      // Loads the data
                      if (snapshots.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      // Handles the null values there is no class data or is empty
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
                      // Extract the class list from the data
                      var classList = snapshots.data as List;

                      return ListView.builder(
                        // Items in the list
                        itemCount: classList.length,
                        itemBuilder: (context, index) {

                          // Use widget to display each class
                          return TeacherClassWidget(
                            classroom: classList[index]['classroom'],
                            subject: classList[index]['subject'],
                            time: classList[index]['time_of_room'],
                            // Pass the classID and tuitionID to the task form
                            function: () =>
                                TaskForm(classList[index]['classID'], widget.tuitionID),
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