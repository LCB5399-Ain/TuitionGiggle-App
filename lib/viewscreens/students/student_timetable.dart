import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/FadeAnimation.dart';
import '../../gethelper/getHelper.dart';
import '../../widget-components/student/timetable_widget.dart';

class StudentTimetable extends StatefulWidget {
  final String studentID;

  StudentTimetable({required this.studentID});

  @override
  _StudentTimetableState createState() => _StudentTimetableState();
}

class _StudentTimetableState extends State<StudentTimetable>{
  var timetable;

  @override
  void initState() {
    timetable = GetHelper.getData(widget.studentID, 'get_student_timetable', 'studentID');
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
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100))
                  ),
                  padding: EdgeInsets.all(20),

                  // Use list view to show data
                  child: FutureBuilder(future: timetable,
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
                            child: Text('You have no timetable currently',
                                style: GoogleFonts.antic(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                )
                            )
                        );
                      }
                      // Use snapshots.data as list
                      var timetableList = snapshots.data as List;

                      return ListView.builder(
                        itemCount: (snapshots.data as List).length,
                        itemBuilder: (context, index) {

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
        ),
      ),
    );
  }
}