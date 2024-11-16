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
// Handles the contact data fetching and UI updates
class _StudentEmergencyState extends State<StudentEmergency>{
  // variable to hold other contacts data.
  var emergencyContact;

  @override
  void initState() {
    super.initState();
    // Use the getHelper to get the contact data
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
          // Code adapted from Yassein, 2020
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
                          // Back arrow button
                          icon: Icon(Icons.arrow_back,
                              color: Colors.white,
                              size: 30
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 70),
                        Text(
                          "Contacts",
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
            // List of contacts
               Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(90),
                          topRight: Radius.circular(90))
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
                        // Handles the null values there is no contact data or is empty
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

                        // Extract the contact list from the data
                        var emergencyList = snapshots.data as List;

                        return ListView.builder(
                          // Items in the list
                        itemCount: emergencyList.length,
                        itemBuilder: (context, index) {
                          // Use widget to display each contact
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
        // End of adapted code
      ),
    );
  }
}