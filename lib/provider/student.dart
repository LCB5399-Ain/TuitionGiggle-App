import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class StudentData{
  final String studentID;
  final String tuitionID;
  final String fullName;
  final String year;
  final String dateOfBirth;
  final String address;
  final String dateOfRegister;

  StudentData({required this.studentID, required this.tuitionID, required this.fullName, required this.year, required this.dateOfBirth, required this.address, required this.dateOfRegister});

}
// Manage student data and handles login
class Student with ChangeNotifier {
  late StudentData _infoData;

  // Use getter to retrieve the student data
  StudentData getStudentData() {
    return _infoData;
  }
  // Code adapted from Yassein, 2020
  // Use setter to update student data
  void setStudentInfo(StudentData info){
    _infoData = info;
    print(_infoData);
    // Notify all the listeners about the new change due to ChangeNotifierProvider
    notifyListeners();
  }

  // Handle the student login with username and password
  Future<bool> loginStudentAndGetInfo(String username, String password) async{
    var responseUrl;

    try {
      // Send the POST request
      responseUrl = await http.post(
          Uri.parse("http://103.253.145.27/appData/login_students.php"),
          body: {
            "username": username.trim(),
            "password": password.trim(),
          }
      );

      // Check if the response status is successful
      if (responseUrl.statusCode == 200) {
        var rawResponse = responseUrl.body;

        if (rawResponse.contains("Connected successfully")) {
          rawResponse = rawResponse.replaceFirst("Connected successfully", "").trim();
        }

        // Decode the cleaned response
        var studentUser = await json.decode(rawResponse);
        // Update the student data if response data is not empty
        if (studentUser.isNotEmpty) {
          AddInfoData(studentUser);
          return true;
        }
      }
    }
      catch(e) {
      print('An error has occurred: $e');
    }
    return false;
  }

  // Insert the retrieved data into the student data object
  AddInfoData(dynamic studentData) {
    StudentData studentInfo = StudentData(
      studentID: studentData[0]['studentID'],
      tuitionID: studentData[0]['tuitionID'],
      fullName: studentData[0]['fullName'],
      year: studentData[0]['year'],
      dateOfBirth: studentData[0]['date_of_birth'],
      address: studentData[0]['address'],
      dateOfRegister: studentData[0]['date_of_register']
    );

    setStudentInfo(studentInfo);
  }
  // End of adapted code

  // Log out the students
  logOut(){
    _infoData = new StudentData(studentID: '', tuitionID: '', fullName: '', year: '', dateOfBirth: '', address: '', dateOfRegister: '');
    notifyListeners(); // Notify about the logout
    print(_infoData.studentID);
  }

}