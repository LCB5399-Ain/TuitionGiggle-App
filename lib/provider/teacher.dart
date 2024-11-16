import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class TeacherInfo{
  final String teacherID;
  final String tuitionID;
  final String fullName;
  final String subject;
  final String phoneNumber;
  final String email;
  final String address;
  final String dateOfRegister;

  TeacherInfo({required this.teacherID, required this.tuitionID, required this.fullName, required this.subject, required this.phoneNumber, required this.email, required this.address, required this.dateOfRegister});

}
// Manage teacher data and handles login
class Teacher with ChangeNotifier {
  late TeacherInfo _info;

  // Use getter to retrieve the teacher data
  TeacherInfo getTeacherInfo() {
    return _info;
  }

  // Use setter to update the teacher data
  void setTeacherInfo(TeacherInfo info){
    _info = info;
    print(_info);
    // Notify all the listeners about the new change
    notifyListeners();
  }

  // Handle the teacher login with username and password
  Future<bool> teacherLoginAndGetInfo(String username, String password) async{
    var response;

    try{
      // Send the POST request
      response = await http.post(
          Uri.parse("http://10.0.2.2/TuitionGiggle/appData/login_teachers.php"),
          body: {
            "username": username.trim(),
            "password": password.trim(),
          }
      );

      // Check if the response status is successful
      if (response.statusCode == 200) {
        var rawResponse = response.body;

        if (rawResponse.contains("Connected successfully")) {
          rawResponse = rawResponse.replaceFirst("Connected successfully", "").trim();
        }

        // Decode the cleaned response
        var datauser = await json.decode(rawResponse);
        // Update the teacher data if response data is not empty
        if (datauser.isNotEmpty) {
          insertInfo(datauser);
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
  insertInfo(dynamic datauser) {
    TeacherInfo teacherInfo = TeacherInfo(
        teacherID: datauser[0]['teacherID'],
        tuitionID: datauser[0]['tuitionID'],
        fullName: datauser[0]['fullName'],
        subject: datauser[0]['subject'],
        phoneNumber: datauser[0]['phoneNumber'],
        email: datauser[0]['email'],
        address: datauser[0]['address'],
        dateOfRegister: datauser[0]['date_of_register']
    );

    setTeacherInfo(teacherInfo);
  }

  // Log out the teachers
  logOut(){
    _info = new TeacherInfo(teacherID: '', tuitionID: '', fullName: '', subject: '', phoneNumber: '', email: '', address: '', dateOfRegister: '');
    notifyListeners(); // Notify about the logout
    print(_info.teacherID);
  }

}