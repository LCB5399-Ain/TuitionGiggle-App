import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
import '../../animation/FadeAnimation.dart';
import '../login.dart';


class MainStudentPage extends StatefulWidget {
  static const routeName = '/main-student-page';

  @override
  _MainStudentPageState createState() => _MainStudentPageState();

}

class _MainStudentPageState extends State<MainStudentPage> {

  late StudentInfo getStudentInfo;

  late String studentID;
  late String studentFullName;
  late String studentYear;
  late String studentDateOfBirth;
  late String studentAddress;
  late String tuitionID;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var state = Provider.of<Student>(context, listen: false).getStudentInfo();
      if (state != null) {
        setState(() {
          getStudentInfo = state;
        });
      } else {
        print('An error has occurred');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // Retrieve student's data
    getStudentInfo = Provider.of<Student>(context).getStudentInfo();
    studentID = getStudentInfo.studentID;
    studentFullName = getStudentInfo.fullName;
    studentYear = getStudentInfo.year;
    tuitionID = getStudentInfo.tuitionID;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                      height: 50,
                    ),

                    Center(
                        child: FadeAnimation(
                            1.3,
                            Text(
                              "Name: $studentFullName",
                              style: GoogleFonts.antic(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                                fontSize: 25,
                              ),
                            )
                        )
                    ),

                    Center(
                        child: FadeAnimation(
                            1.3,
                            Text(
                              "Year: $studentYear",
                              style: GoogleFonts.asar(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                                fontSize: 23,
                              ),
                            )
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)
                      )
                  ),
                  padding: EdgeInsets.all(20),
                  child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20.0),
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        CardItem(
                          desc: 'Student Bio',
                          img: 'assets/student_icon.png',
                          color: Color.fromRGBO(116, 164, 199, 1),
                          function: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentBio(
                                  fullName: getStudentInfo.fullName,
                                  year: getStudentInfo.year,
                                  dateOfBirth: getStudentInfo.dateOfBirth,
                                  address: getStudentInfo.address,
                                ),
                              ),
                            );
                          },
                        ),

                        CardItem(
                          desc: 'Announcement',
                          img: 'assets/announcement.jpeg',
                          color: Color.fromRGBO(247, 206, 61, 1),
                          function: () {
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

                        CardItem(
                          desc: 'Class',
                          img: 'assets/class_icon.png',
                          color: Color.fromRGBO(247, 206, 61, 1),
                          function: () {
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

                        CardItem(
                          desc: 'Timetable',
                          img: 'assets/timetable_icon.png',
                          color: Color.fromRGBO(116, 164, 199, 1),
                          function: () {
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

                        CardItem(
                          desc: 'Contacts',
                          img: 'assets/emergency_icon.png',
                          color: Color.fromRGBO(116, 164, 199, 1),
                          function: () {
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

                        CardItem(
                          desc: 'Receipt',
                          img: 'assets/fee_icon.png',
                          color: Color.fromRGBO(247, 206, 61, 1),
                          function: () {
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

                        CardItem(
                          desc: 'Feedback',
                          img: 'assets/feedback_icon.png',
                          color: Color.fromRGBO(247, 206, 61, 1),
                          function: () {
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

                        CardItem(
                          desc: 'Complaints',
                          img: 'assets/complaints_icon.png',
                          color: Color.fromRGBO(116, 164, 199, 1),
                          function: () {
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

                        CardItem(
                            desc: 'Logout',
                            img: 'assets/logout.png',
                            color: Color.fromRGBO(116, 164, 199, 1),
                            function: () {
                              Provider.of<Student>(context, listen: false).logOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()
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
    );
  }

}

