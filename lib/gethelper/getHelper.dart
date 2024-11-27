import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/viewscreens/students/main_student_page.dart';
import '../viewscreens/teachers/main_teacher_page.dart';
import 'package:http/http.dart' as http;

var apiShortcut = 'http://10.0.2.2/TuitionGiggle';

class GetHelper{

  // Retrieve the data from the server
  static Future<dynamic> fetchData (
      String studentID,
      String dataType,
      String dataKey) async {

    try {
      // Use POST request to send to the server
      final responseUrl = await http.post(
          Uri.parse("http://10.0.2.2/TuitionGiggle/appData/retrieve_data/$dataType.php"),
         body: {
          "$dataKey": studentID,
        },
      );

      // Check the response.status code 200 is success and response.body is not empty
      if (responseUrl.statusCode == 200 && responseUrl.body.isNotEmpty) {

        String rawResponse = responseUrl.body;
        String jsonResponse = rawResponse.replaceFirst("Connected successfully", "").trim();
        // Parse the JSON response
        if (jsonResponse.isNotEmpty) {
          return json.decode(jsonResponse);
        }
      } else {
        // Display the message
        print("Failed to retrieve data: ${responseUrl.statusCode} or the response body is empty");
        return null;
      }
    // Catch the errors in the HTTP request
    } catch (e) {
      print("Error fetching the data: $e");
      return null;
    }
  }

  // Code adapted from Yassein, 2020
  // Validate the form using form key
  static Future<void> submitComplaints(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String role,
      String fullName,
      String phoneNumber,
      String title,
      String feedback,
      String tuitionID) async {
    // Ensure the form is valid before proceeding
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      // Prepare the data to send to the server
      final uri = Uri.parse(
          "http://10.0.2.2/TuitionGiggle/appData/add_data/insert_complaints.php");
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'tuitionID': tuitionID,
          'role': role,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'title': title,
          'feedback': feedback,
        }),
      );

      // Check if the response was successful with JSON
      if (response.statusCode == 200) {
        final responseMessage = jsonDecode(response.body);

        print('Complaint submitted successfully: $responseMessage');
      }
    } catch (e) {
      // Catch and print any errors that occur during the HTTP request
      print('Error submitting complaint: $e');
    }
  }

    // Validate the form using form key
    static Future<void> submitTask(
    GlobalKey<FormState> formKey,
    BuildContext context,
    String tuitionID,
    String classID,
    String subject,
    String task
        ) async {

      // Validate the form before proceeding
      if (!formKey.currentState!.validate()) {
        return;
      }

      try {
        // Prepare the data to send to the server
        final uri = Uri.parse(
            "http://10.0.2.2/TuitionGiggle/appData/add_data/insert_tasks.php");
        final response = await http.post(
          uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            'tuitionID': tuitionID,
            'classID': classID,
            'subject': subject,
            'task': task,
          }),
        );
        // End of adapted code

        // Handle the response from the server
        if (response.statusCode == 200) {
          // Parse the response message
          final msg = jsonDecode(response.body);
          print('Server Response: $msg');

        } else {

          print('Failed to submit task: ${response.statusCode}');
        }
      } catch (e) {

        print('Error submitting task: $e');
      }
    }
}
