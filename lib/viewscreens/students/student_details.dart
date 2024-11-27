import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../animation/AnimationWidget.dart';

class StudentBio extends StatefulWidget {
  final String fullName;
  final String year;
  final String dateOfBirth;
  final String address;

  StudentBio({required this.fullName, required this.year, required this.dateOfBirth, required this.address});

  @override
  _StudentBioState createState() => _StudentBioState();

}

class _StudentBioState extends State<StudentBio> {
  late final String fullName;
  late final String year;
  late final String dateOfBirth;
  late final String address;

  @override
  void initState() {
    super.initState();

    // Set the variables with widget properties
    fullName = widget.fullName;
    year = widget.year;
    dateOfBirth = widget.dateOfBirth;
    address = widget.address;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  SizedBox(width: 14),
                  Text(
                    "Student Information",
                    style: GoogleFonts.antic(
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
              // Main content page
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(90),
                        topRight: Radius.circular(90)),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage('assets/student_bio1.jpg',
                              ),
                              fit: BoxFit.cover,
                          ),
                        ),
                        ),
                        SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3)
                            ),
                            ],
                      ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                               Text('Name: $fullName',
                                      style: TextStyle(
                                      fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                 ),
                               ),
                               SizedBox(height: 8),

                              Text('Year: $year',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),

                              Text('Date of Birth: $dateOfBirth',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),

                              Text('Address: $address',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                      ),
                  ),
                  ],
                ),
              ),
          ),
        ],
      ),
    ),
   );

  }
}

