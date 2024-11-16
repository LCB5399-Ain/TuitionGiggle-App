import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/FadeAnimation.dart';
import '../../gethelper/getHelper.dart';
import '../../widget-components/student/task_widget.dart';

class Task extends StatefulWidget {
  final String classID;

  Task({required this.classID});

  @override
  _TaskState createState() => _TaskState();

}
// Handles the class data fetching and UI updates
class _TaskState extends State<Task>{
  var classes;

  @override
  void initState() {
    // Use the getHelper to get the task data
    classes = GetHelper.getData(widget.classID, 'get_student_task', 'classID');
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
                  SizedBox(
                    height: 40,
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
                        SizedBox(width: 100),
                        Text(
                          "Task",
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
            // List of tasks
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
                  child: FutureBuilder(
                    future: classes,
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
                            child: Text('You have no tasks',
                                style: GoogleFonts.antic(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30
                                )
                            )
                        );
                      }
                      // Extract the class list from the data
                      var taskList = snapshots.data as List;

                      return ListView.builder(
                        // Items in the list
                        itemCount: taskList.length,
                        itemBuilder: (context, index) {
                          // Use widget to display each task
                          return TaskWidget(
                            subject: taskList[index]['subject'] ?? 'No Subject',
                            task: taskList[index]['task'] ?? 'No Task',
                            dateOfTask: taskList[index]['date_of_task'] ?? 'No Date',
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