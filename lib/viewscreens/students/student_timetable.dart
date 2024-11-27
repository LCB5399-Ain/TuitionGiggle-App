import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/AnimationWidget.dart';
import '../../gethelper/getHelper.dart';
import '../../widget-components/student/timetable_widget.dart';

class StudentTimetable extends StatefulWidget {
  final String studentID;

  StudentTimetable({required this.studentID});

  @override
  _StudentTimetableState createState() => _StudentTimetableState();
}
// Handles the timetable data fetching and UI updates
class _StudentTimetableState extends State<StudentTimetable> {
  // Variable to hold other timetable data.
  late Future<List> timetable;

  // Fetch timetable data
  Future<List> _fetchtimetableData() async {
    try {
      var response = await GetHelper.fetchData(widget.studentID, 'get_student_timetable', 'studentID');
      return response;
    } catch (e) {
      throw Exception('There is an error fetching timetable data: $e');
    }
  }

  @override
  void initState() {
    // Get the future timetable data
    timetable = _fetchtimetableData();
    super.initState();

    // Print the response from php website
    timetable.then((response) {
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
                        SizedBox(width: 65),
                        Text(
                          "Timetable",
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
            // List of classes
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(90),
                          topRight: Radius.circular(90))
                  ),
                  padding: const EdgeInsets.all(20),

                  // Use list view to show data
                  // Code adapted from SilasPaes, 2019
                  child: FutureBuilder(future: timetable,
                    builder: (context, snapshots) {
                      // Loads the data
                      if (snapshots.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        // End of adapted code
                      }

                      // Handles the null values there is no timetable data or is empty
                      if (!snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                        return Center(
                            child: Text('You have no timetable currently',
                                style: GoogleFonts.lato(
                                    fontSize: 20
                                )
                            )
                        );
                      }
                      // Extract the class list from the data
                      var timetableList = snapshots.data as List;

                      return ListView.builder(
                        // Items in the list
                        itemCount: (snapshots.data as List).length,
                        itemBuilder: (context, index) {
                          // Use the widget to display each timetable
                          return TimetableWidget(
                            classroom: timetableList[index]['classroom'] ?? 'No Classroom',
                            subject: timetableList[index]['subject'] ?? 'No Subject',
                            day: timetableList[index]['day'] ?? 'No Day',
                            timeOfRoom: timetableList[index]['time_of_room'] ?? 'No Time',
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