import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/AnimationWidget.dart';

class TimetableWidget extends StatelessWidget {
  final String classroom;
  final String subject;
  final String day;
  final String timeOfRoom;

  TimetableWidget({this.classroom="", this.subject="", this.day="", this.timeOfRoom=""});

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
                blurRadius: 4,
                offset: Offset(0, 2),
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
                child: Image.asset('assets/timetable_icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            title: Text(subject,
              style: GoogleFonts.lato(
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
                    day,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            // Code adapted from Yassein, 2020
            onTap:() {
              showDialog(
                context: context,
                builder: (_) {
                  return WidgetFadeAnimation(1.3,
                    AlertDialog(
                    title: Text(subject, textAlign: TextAlign.center),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    content: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(thickness: 1.3),
                            const SizedBox(height: 8.0),
                          // End of adapted code

                          Row(
                            children: [
                              Icon(Icons.location_on, color: Color.fromRGBO(116, 164, 199, 1)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  classroom,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),

                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Color.fromRGBO(116, 164, 199, 1)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  day,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                            const SizedBox(height: 25),

                          Row(
                            children: [
                              Icon(Icons.access_time, color: Color.fromRGBO(116, 164, 199, 1)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  timeOfRoom,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                            const SizedBox(height: 25),

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