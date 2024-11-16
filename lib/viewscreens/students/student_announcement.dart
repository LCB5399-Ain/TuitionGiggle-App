import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/FadeAnimation.dart';
import '../../gethelper/getHelper.dart';

class StudentAnnouncement extends StatefulWidget {
  final String tuitionID;

  StudentAnnouncement({required this.tuitionID});

  @override
  _StudentAnnouncementState createState() => _StudentAnnouncementState();
  
}

// Handles the announcement data fetching and UI updates
class _StudentAnnouncementState extends State<StudentAnnouncement> {
  var announcements;

  @override
  void initState() {
    super.initState();
    // Use the getHelper to get the announcement data
    announcements = GetHelper.getData(
        widget.tuitionID, 'get_student_announcement', 'tuitionID');

    // Prints the response from php website
    announcements.then((response) {
      print("Raw Response: $response");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromRGBO(116, 164, 199, 1)
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
                        SizedBox(width: 20),
                        Text(
                          "Announcements",
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
            // List of announcements
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(90),
                      topRight: Radius.circular(90)),
                ),
                padding: EdgeInsets.all(20),

                // // Use list view to show the data
                child: FutureBuilder(
                  future: announcements,
                  builder: (context, snapshots) {
                    // Loads the data
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // Handles the null values there is no announcement data or is empty
                    if (snapshots.hasError || !snapshots.hasData || snapshots.data == null || (snapshots.data as List).isEmpty) {
                      return Center(
                        child: Text('There is no announcement available at the moment.',
                          style: GoogleFonts.antic(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }

                    // Extract the class list from the data
                    var announcementList = snapshots.data as List;

                    return ListView.builder(
                      itemCount: announcementList.length,
                      itemBuilder: (context, index) {
                        String title = announcementList[index]['title'] ?? 'No Title';
                        String announcement = announcementList[index]['announcement'] ?? 'No Announcement';
                        String dateOfAnnouncement = announcementList[index]['date_of_announcement'] ?? 'Unknown Date';
                        // End of adapted code

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          color: Colors.white,
                          elevation: 4,
                          child: ListTile(
                            title: Text(title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              ),
                            ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(announcement,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        dateOfAnnouncement,
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.grey
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

