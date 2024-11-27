import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/AnimationWidget.dart';
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
  late Future<List> classes;

  // Fetch task data
  Future<List> _fetchTaskData() async {
    try {
      var response = await GetHelper.fetchData(widget.classID, 'get_student_task', 'classID');
      return response;
    } catch (e) {
      throw Exception('There is an error fetching task data: $e');
    }
  }

  @override
  void initState() {
    // Use the getHelper to get the task data
    // Get the future task data
    classes = _fetchTaskData();
    super.initState();

    // Print the response from php website
    classes.then((response) {
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
                        SizedBox(width: 100),
                        Text(
                          "Task",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
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
                  padding: EdgeInsets.all(18),

                  // Use list view to show data
                  // Code adapted from SilasPaes, 2019
                  child: FutureBuilder(
                    future: classes,
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
                            child: Text('You have no tasks currently',
                                style: GoogleFonts.lato(
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
                          // Use the widget to display each task
                          return TaskWidget(
                            subjectOfTask: taskList[index]['subject'] ?? 'No Subject',
                            task: taskList[index]['task'] ?? 'No Task',
                            taskDate: taskList[index]['date_of_task'] ?? 'No Date',
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