import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/viewscreens/students/main_student_page.dart';
import '../viewscreens/teachers/main_teacher_page.dart';
import 'package:http/http.dart' as http;


class GetHelper{

  static Future getData (
      String dataID, String typeOfData, String inputData) async {
    try {
      final response = await http.post(
          Uri.parse("http://10.0.2.2/TuitionGiggle/for_app/get_data/$typeOfData.php"),
        body: {
          "$inputData": dataID,
        }
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {

        String rawResponse = response.body;
        String jsonResponse = rawResponse.replaceFirst("Connected successfully", "").trim();

        if (jsonResponse.isNotEmpty) {
          return json.decode(jsonResponse);
        }
      } else {
        print("Failed to retrieve data: ${response.statusCode} or the response body is empty");
        return null;
      }

    } catch (e) {
      print("Error fetching the data: $e");
      return null;
    }
  }

  static Future submitComplaints(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String role,
      String fullName,
      String phoneNumber,
      String title,
      String feedback,
      String tuitionID
      ) async {
    if (formKey.currentState!.validate()) {
      try {
        var data = {
          'tuitionID': tuitionID,
          'role': role,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'title': title,
          'feedback': feedback
        };

        var response = await http.post(
          Uri.parse("http://10.0.2.2/TuitionGiggle/for_app/insert_data/insert_complaints.php"),
          body: json.encode(data),
        );

        if (response.statusCode == 200) {
          var msg = jsonDecode(response.body);
          print(msg);

          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(child: Text('Thank You!')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),

                content: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            msg,
                            style: GoogleFonts.antic(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                          )
                        ),

                        Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                            ),
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).pushNamed(MainStudentPage.routeName);
                            },
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              );
            }
          );
        }
      }
      catch (e) {
        print (e);
      }
    }
  }

  static Future submitTask(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String tuitionID,
      String classID,
      String subject,
      String task
      ) async {
    if (formKey.currentState!.validate()) {
      try {
        var data = {
          'tuitionID': tuitionID,
          'classID': classID,
          'subject': subject,
          'task': task,
        };

        var response = await http.post(
          Uri.parse("http://10.0.2.2/TuitionGiggle/for_app/insert_data/insert_tasks.php"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(data),
        );

        if (response.statusCode == 200) {
          var msg = jsonDecode(response.body);
          print('Response server: $msg');

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Thank You!')),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),

                  content: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Text(
                                msg,
                                style: GoogleFonts.antic(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),
                                ),
                              )
                          ),

                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pushNamed(MainTeacherPage.routeName);
                              },
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      } catch (e) {
        print(e);
      }
    }
  }
}