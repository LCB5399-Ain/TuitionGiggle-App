import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class TeacherData{
  final String teacherID;
  final String tuitionID;
  final String fullName;
  final String subject;
  final String phoneNumber;
  final String email;
  final String address;
  final String dateOfRegister;

  TeacherData({required this.teacherID, required this.tuitionID, required this.fullName, required this.subject, required this.phoneNumber, required this.email, required this.address, required this.dateOfRegister});

}
// Manage teacher data and handles login
class Teacher with ChangeNotifier {
  late TeacherData _infoData;

  // Use getter to retrieve the teacher data
  TeacherData getTeacherData() {
    return _infoData;
  }
// Code adapted from Yassein, 2020
  // Use setter to update the teacher data
  void setTeacherInfo(TeacherData info){
    _infoData = info;
    print(_infoData);
    // Notify all the listeners about the new change
    notifyListeners();
  }

  // Handle the teacher login with username and password
  Future<bool> teacherLoginAndGetInfo(String username, String password) async{
    var responseUrl;

    try{
      // Send the POST request
      responseUrl = await http.post(
          Uri.parse("http://103.253.145.27/appData/login_teachers.php"),
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
        var teacherUser = await json.decode(rawResponse);
        // Update the teacher data if response data is not empty
        if (teacherUser.isNotEmpty) {
          AddInfoData(teacherUser);
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
  AddInfoData(dynamic teacherData) {
    TeacherData teacherInfo = TeacherData(
        teacherID: teacherData[0]['teacherID'],
        tuitionID: teacherData[0]['tuitionID'],
        fullName: teacherData[0]['fullName'],
        subject: teacherData[0]['subject'],
        phoneNumber: teacherData[0]['phoneNumber'],
        email: teacherData[0]['email'],
        address: teacherData[0]['address'],
        dateOfRegister: teacherData[0]['date_of_register']
    );

    setTeacherInfo(teacherInfo);
  }
  // End of adapted code

  // Log out the teachers
  logOut(){
    _infoData = new TeacherData(teacherID: '', tuitionID: '', fullName: '', subject: '', phoneNumber: '', email: '', address: '', dateOfRegister: '');
    notifyListeners(); // Notify about the logout
    print(_infoData.teacherID);
  }

}