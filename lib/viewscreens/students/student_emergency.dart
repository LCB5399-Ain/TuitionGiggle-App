import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/FadeAnimation.dart';
import 'package:tuitiongiggle/gethelper/getHelper.dart';
import '../../widget-components/student/emergency_widget.dart';


class StudentEmergency extends StatefulWidget {
  final String studentID;

  StudentEmergency({required this.studentID});

  @override
  _StudentEmergencyState createState() => _StudentEmergencyState();

}

class _StudentEmergencyState extends State<StudentEmergency>{

  var emergencyContact;

  @override
  void initState() {
    super.initState();
    emergencyContact = GetHelper.getData(widget.studentID, 'get_student_emergencyContacts', 'studentID');

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
                  SizedBox(height: 40),
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
                        SizedBox(width: 10),
                        Text(
                          "Emergency Contact",
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
                    child: FutureBuilder(future: emergencyContact,
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
                            child: Text('There are no emergency contacts for this student',
                            style: GoogleFonts.antic(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                                )
                              )
                          );
                        }

                        // Use snapshots.data as list
                        var emergencyList = snapshots.data as List;

                        return ListView.builder(
                        itemCount: emergencyList.length,
                        itemBuilder: (context, index) {

                          return EmergencyWidget(
                            relationship: emergencyList[index]['relationship'],
                            fullName: emergencyList[index]['fullName'],
                            phoneNumber: emergencyList[index]['phoneNumber'],
                            email: emergencyList[index]['email'],
                            address: emergencyList[index]['address'],
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