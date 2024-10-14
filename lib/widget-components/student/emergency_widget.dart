import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/FadeAnimation.dart';

class EmergencyWidget extends StatelessWidget {
  final String relationship;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String address;

  EmergencyWidget({this.relationship="", this.fullName="", this.phoneNumber="", this.email="", this.address=""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white, // Box background color
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
                ),
               ],
              ),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/emergency_icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                  title: Text(relationship,
                    style: GoogleFonts.antic(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                    ),
                  ),
              ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name: $fullName',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4),
                    Text(
                    'Phone No: $phoneNumber',
                    style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
              ),
                      SizedBox(height: 4),
                    ],
                  ),

              onTap:() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FadeAnimation(1.5, AlertDialog(
                          title: Center(child: Text(relationship)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                  Divider(thickness: 1.5,),
                                  SizedBox(height: 10,),

                                Row(
                                  children: [
                                    Icon(Icons.person, color: Color.fromRGBO(116, 164, 199, 1)),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        fullName,
                                        style: GoogleFonts.antic(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),

                                Row(
                                  children: [
                                    Icon(Icons.phone, color: Color.fromRGBO(116, 164, 199, 1)),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        phoneNumber,
                                        style: GoogleFonts.antic(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),

                                // Email
                                Row(
                                  children: [
                                    Icon(Icons.email, color: Color.fromRGBO(116, 164, 199, 1)),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        email,
                                        style: GoogleFonts.antic(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),

                                // Address
                                Row(
                                  children: [
                                    Icon(Icons.home, color: Color.fromRGBO(116, 164, 199, 1)),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        address,
                                        style: GoogleFonts.antic(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              ),
                            ),
                          ),
                        actions: [
                          TextButton(
                            child:
                            Text(
                              'Close',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(116, 164, 199, 1),
                              ),
                            ),

                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      );
                    },
                );
              },
              ),
        ),
      ],
    );
  }
}