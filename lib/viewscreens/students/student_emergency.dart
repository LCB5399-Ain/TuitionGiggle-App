import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/animation/AnimationWidget.dart';
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
  late Future<List> emergencyContact;

  // Fetch timetable data
  Future<List> _fetchContactData() async {
    try {
      var response = await GetHelper.fetchData(widget.studentID, 'get_student_emergencyContacts', 'studentID');
      return response;
    } catch (e) {
      throw Exception('There is an error fetching contact data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Get the future contact data
    emergencyContact = _fetchContactData();

    // Print the response from php website
    emergencyContact.then((response) {
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
                  SizedBox(height: 40),
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
                         const SizedBox(width: 70),
                        Text(
                          "Contacts",
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
                      // Code adapted from SilasPaes, 2019
                    child: FutureBuilder(future: emergencyContact,
                      builder: (context, snapshots) {
                        // Loads the data
                        if (snapshots.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                          // End of adapted code
                        }
                        // Handles the null values there is no contact data or is empty
                        if (!snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                          return Center(
                            child: Text('There are no emergency contacts for this student',
                            style: GoogleFonts.antic(
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
                          return ContactWidget(
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