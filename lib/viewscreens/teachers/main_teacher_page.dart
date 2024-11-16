import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tuitiongiggle/viewscreens/teachers/teacher_class.dart';
import 'package:tuitiongiggle/viewscreens/teachers/teacher_details.dart';
import '../../animation/FadeAnimation.dart';
import '../../provider/teacher.dart';
import '../../widget-components/cardItem.dart';
import '../login.dart';
import '../students/student_announcement.dart';

// This is the home main page for teachers
class MainTeacherPage extends StatefulWidget {
  // Navigate teacher users to this page name
  static const routeName = '/main-teacher-page';

  @override
  _MainTeacherPageState createState() => _MainTeacherPageState();

}

class _MainTeacherPageState extends State<MainTeacherPage> {

  late TeacherInfo getTeacherInfo;

  late String teacherID;
  late String teacherFullName;
  late String teacherSubject;
  late String teacherPhoneNumber;
  late String teacherEmail;
  late String teacherAddress;
  late String tuitionID;

  @override
  Widget build(BuildContext context) {
    // Retrieve the teacher data using Provider
    getTeacherInfo = Provider.of<Teacher>(context).getTeacherInfo();

    teacherID = getTeacherInfo.teacherID;
    teacherFullName = getTeacherInfo.fullName;
    teacherSubject = getTeacherInfo.subject;
    teacherPhoneNumber = getTeacherInfo.phoneNumber;
    teacherEmail = getTeacherInfo.email;
    teacherAddress = getTeacherInfo.address;
    tuitionID = getTeacherInfo.tuitionID;

    // Code adapted from Yassein, 2020
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold (
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
                    // Place teacher information header in the center
                    Center(
                      child: FadeAnimation(
                        1.3,
                        Text(
                          "Teacher: $teacherFullName",
                          style: GoogleFonts.antic(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                            fontSize: 25,
                          ),
                        )
                      )
                    ),

                    Center(
                        child: FadeAnimation(
                            1.3,
                            Text(
                              "Subject: $teacherSubject",
                              style: GoogleFonts.antic(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                fontSize: 25,
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
              // Display all the card items
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
                    crossAxisSpacing: 10, // grid spacing
                    crossAxisCount: 2,
                    children: <Widget>[

                      CardItem(
                        desc: 'Teacher Bio',
                        img: 'assets/teacher_icon.png',
                        color: Color.fromRGBO(116, 164, 199, 1),
                        function: () {
                          Navigator.push(
                            context,
                            // Navigate user to the TeacherBio page
                            MaterialPageRoute(
                              builder: (context) => TeacherBio(
                                fullName: getTeacherInfo.fullName,
                                subject: getTeacherInfo.subject,
                                email: getTeacherInfo.email,
                                address: getTeacherInfo.address,
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
                        function: () { Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherClass(
                              teacherID: teacherID,
                              tuitionID: tuitionID)
                          ),
                        );
                        }
                      ),
                      // Logout and direct users to login page
                      CardItem(
                          desc: 'Logout',
                          img: 'assets/logout.png',
                          color: Color.fromRGBO(116, 164, 199, 1),
                          function: () {
                            Provider.of<Teacher>(context, listen: false).logOut();
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                          }
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    // End of adapted code
  }
}
