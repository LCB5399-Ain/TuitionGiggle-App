import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tuitiongiggle/viewscreens/teachers/teacher_class.dart';
import 'package:tuitiongiggle/viewscreens/teachers/teacher_details.dart';
import '../../animation/AnimationWidget.dart';
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

  late TeacherData getTeacherData;

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
    getTeacherData = Provider.of<Teacher>(context).getTeacherData();

    if (getTeacherData == null) {
      return const Center(
          child: CircularProgressIndicator()
      );
    }

    teacherID = getTeacherData.teacherID;
    teacherFullName = getTeacherData.fullName;
    teacherSubject = getTeacherData.subject;
    teacherPhoneNumber = getTeacherData.phoneNumber;
    teacherEmail = getTeacherData.email;
    teacherAddress = getTeacherData.address;
    tuitionID = getTeacherData.tuitionID;

    // Code adapted from Yassein, 2020
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold (
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
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
                        1.2,
                        Center(
                          child: Text(
                            "$teacherFullName",
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
                              "Subject: $teacherSubject",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70)
                    )
                  ),
                  padding: EdgeInsets.all(20),
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(18),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    children: <Widget>[

                      MainBox(
                        textDesc: 'Teacher Bio',
                        image: 'assets/teacher_icon.png',
                        backgroundColor: Color.fromRGBO(116, 164, 199, 1),
                        onTap: () {
                          Navigator.push(
                            context,
                            // Navigate user to the TeacherBio page
                            MaterialPageRoute(
                              builder: (context) => TeacherBio(
                                fullName: getTeacherData.fullName,
                                subject: getTeacherData.subject,
                                email: getTeacherData.email,
                                address: getTeacherData.address,
                              ),
                            ),
                          );
                        },
                      ),

                      MainBox(
                        textDesc: 'Announcement',
                        image: 'assets/announcement.jpeg',
                        backgroundColor: Color.fromRGBO(247, 206, 61, 1),
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
                          backgroundColor: Color.fromRGBO(247, 206, 61, 1),
                          onTap: () { Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherClass(
                              teacherID: teacherID,
                              tuitionID: tuitionID)
                          ),
                        );
                        }
                      ),
                      // Logout and direct users to login page
                      MainBox(
                          textDesc: 'Logout',
                          image: 'assets/logout.png',
                          backgroundColor: Color.fromRGBO(116, 164, 199, 1),
                          onTap: () {
                            Provider.of<Teacher>(context, listen: false).logOut();
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
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
      )
    );
    // End of adapted code
  }
}
