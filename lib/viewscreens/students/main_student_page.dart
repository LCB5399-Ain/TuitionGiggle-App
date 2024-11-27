import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tuitiongiggle/main.dart';
import 'package:tuitiongiggle/provider/student.dart';
import 'package:tuitiongiggle/viewscreens/students/student_announcement.dart';
import 'package:tuitiongiggle/viewscreens/students/student_class.dart';
import 'package:tuitiongiggle/viewscreens/students/student_complaints.dart';
import 'package:tuitiongiggle/viewscreens/students/student_details.dart';
import 'package:tuitiongiggle/viewscreens/students/student_emergency.dart';
import 'package:tuitiongiggle/viewscreens/students/student_fee.dart';
import 'package:tuitiongiggle/viewscreens/students/student_feedback.dart';
import 'package:tuitiongiggle/viewscreens/students/student_timetable.dart';
import 'package:tuitiongiggle/widget-components/cardItem.dart';
import '../../animation/AnimationWidget.dart';
import '../login.dart';

// This is the home main page for students
class MainStudentPage extends StatefulWidget {
  static const routeName = '/main-student-page';

  @override
  _MainStudentPageState createState() => _MainStudentPageState();

}

class _MainStudentPageState extends State<MainStudentPage> {

  late StudentData getStudentData;
  late String studentID;
  late String studentFullName;
  late String studentYear;
  late String studentDateOfBirth;
  late String studentAddress;
  late String tuitionID;

  @override
  void initState() {
    super.initState();
    // Get the student data from the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {

      var state = Provider.of<Student>(context, listen: false).getStudentData();
      if (state != null) {
        setState(() {
          getStudentData = state;
        });
      } else {
        // Print error if it fails
        print('An error has occurred');
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    // Retrieve the student data using Provider
    getStudentData = Provider.of<Student>(context).getStudentData();
    if (getStudentData == null) {
      return const Center(
          child: CircularProgressIndicator()
      );
    }

    studentID = getStudentData.studentID;
    studentFullName = getStudentData.fullName;
    studentYear = getStudentData.year;
    tuitionID = getStudentData.tuitionID;


    // Code adapted from Yassein, 2020
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration:  const BoxDecoration(
              color: Color.fromRGBO(116, 164, 199, 1)
          ),

          child: Center (
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetFadeAnimation(
                      1.2, // Animation duration or start delay
                      Center(
                        child: Text(
                          "Name: $studentFullName",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    WidgetFadeAnimation(
                      1.2,
                      Center(
                        child: Text(
                          "Year: $studentYear",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Display all the card items
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70)
                      )
                  ),
                  padding: EdgeInsets.all(20),
                  child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      children: <Widget>[

                        MainBox(
                          textDesc: 'Student Bio',
                          image: 'assets/student_icon.png',
                          backgroundColor: Color.fromRGBO(116, 164, 199, 1),
                          onTap: () {
                            // Navigate user to the Student detail page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentBio(
                                  fullName: getStudentData.fullName,
                                  year: getStudentData.year,
                                  dateOfBirth: getStudentData.dateOfBirth,
                                  address: getStudentData.address,
                                ),
                              ),
                            );
                          },
                        ),

                        MainBox(
                          textDesc: 'Announcement',
                          image: 'assets/announcement.jpeg',
                          backgroundColor: const Color.fromRGBO(247, 206, 61, 1),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentAnnouncement(
                                    tuitionID: tuitionID,
                                  )
                              ),
                            );
                          },
                        ),

                        MainBox(
                          textDesc: 'Class',
                          image: 'assets/class_icon.png',
                          backgroundColor: const Color.fromRGBO(247, 206, 61, 1),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentClass(
                                    studentID: studentID,
                                  )
                              ),
                            );
                          },
                        ),

                        MainBox(
                          textDesc: 'Timetable',
                          image: 'assets/timetable_icon.png',
                          backgroundColor: const Color.fromRGBO(116, 164, 199, 1),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentTimetable(
                                    studentID: studentID,
                                  )
                              ),
                            );
                          },
                        ),

                        MainBox(
                          textDesc: 'Contacts',
                          image: 'assets/emergency_icon.png',
                          backgroundColor: const Color.fromRGBO(116, 164, 199, 1),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentEmergency(
                                    studentID: studentID,
                                  )
                              ),
                            );
                          },
                        ),

                        MainBox(
                          textDesc: 'Receipt',
                          image: 'assets/fee_icon.png',
                          backgroundColor: const Color.fromRGBO(247, 206, 61, 1),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentFee(
                                    studentID: studentID,
                                  )
                              ),
                            );
                          },
                        ),

                        MainBox(
                          textDesc: 'Feedback',
                          image: 'assets/feedback_icon.png',
                          backgroundColor: const Color.fromRGBO(247, 206, 61, 1),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentFeedback(
                                    studentID: studentID,
                                  )
                              ),
                            );
                          },
                        ),

                        MainBox(
                          textDesc: 'Complaints',
                          image: 'assets/complaints_icon.png',
                          backgroundColor: const Color.fromRGBO(116, 164, 199, 1),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentComplaints(
                                    tuitionID: tuitionID,
                                  )
                              ),
                            );
                          },
                        ),
                        // Logout and direct users to login page
                        MainBox(
                            textDesc: 'Logout',
                            image: 'assets/logout.png',
                            backgroundColor: const Color.fromRGBO(116, 164, 199, 1),
                            onTap: () {
                              Provider.of<Student>(context, listen: false).logOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()
                                ),
                              );
                            }
                        ),
                      ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      )
    );
    // End of adapted code
  }

}

