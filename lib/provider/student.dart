import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class StudentInfo{
  final String studentID;
  final String tuitionID;
  final String fullName;
  final String year;
  final String dateOfBirth;
  final String address;
  final String dateOfRegister;

  StudentInfo({required this.studentID, required this.tuitionID, required this.fullName, required this.year, required this.dateOfBirth, required this.address, required this.dateOfRegister});

}

class Student with ChangeNotifier {
  late StudentInfo _info;

  StudentInfo getStudentInfo() {
    return _info;
  }

  void setStudentInfo(StudentInfo info){
    _info=info;
    print(_info);
    notifyListeners();
  }

  Future<bool> loginStudentAndGetInfo(String username, String password) async{
    var response;

    try {
      response = await http.post(
          Uri.parse("http://10.0.2.2/TuitionGiggle/appData/login_students.php"),
          body: {
            "username": username.trim(),
            "password": password.trim(),
          }
      );

      if (response.statusCode == 200) {
        var rawResponse = response.body;

        if (rawResponse.contains("Connected successfully")) {
          rawResponse = rawResponse.replaceFirst("Connected successfully", "").trim();
        }

        // Decode the cleaned response
        var datauser = await json.decode(rawResponse);

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

  insertInfo(dynamic datauser) {
    StudentInfo studentInfo = StudentInfo(
      studentID: datauser[0]['studentID'],
      tuitionID: datauser[0]['tuitionID'],
      fullName: datauser[0]['fullName'],
      year: datauser[0]['year'],
      dateOfBirth: datauser[0]['date_of_birth'],
      address: datauser[0]['address'],
      dateOfRegister: datauser[0]['date_of_register']
    );

    setStudentInfo(studentInfo);
  }

  logOut(){
    _info = new StudentInfo(studentID: '', tuitionID: '', fullName: '', year: '', dateOfBirth: '', address: '', dateOfRegister: '');
    notifyListeners();
    print(_info.studentID);
  }

}