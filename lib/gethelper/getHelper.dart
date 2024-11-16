import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuitiongiggle/viewscreens/students/main_student_page.dart';
import '../viewscreens/teachers/main_teacher_page.dart';
import 'package:http/http.dart' as http;


class GetHelper{

  // Retrieve the data from the server
  static Future getData (
      String studentID, String dataType, String dataKey) async {
    try {
      // Use POST request to send to the server
      final response = await http.post(
          Uri.parse("http://10.0.2.2/TuitionGiggle/appData/retrieve_data/$dataType.php"),
        body: {
          "$dataKey": studentID,
        }
      );

      // Check the response.status code 200 is success and response.body is not empty
      if (response.statusCode == 200 && response.body.isNotEmpty) {

        String rawResponse = response.body;
        String jsonResponse = rawResponse.replaceFirst("Connected successfully", "").trim();
        // Parse the JSON response
        if (jsonResponse.isNotEmpty) {
          return json.decode(jsonResponse);
        }
      } else {
        // Display the message
        print("Failed to retrieve data: ${response.statusCode} or the response body is empty");
        return null;
      }
    // Catch the errors in the HTTP request
    } catch (e) {
      print("Error fetching the data: $e");
      return null;
    }
  }

  // Validate the form using form key
  static Future submitComplaints(
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
      Map<String, String> complaintData = {
        'tuitionID': tuitionID,
        'role': role,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'title': title,
        'feedback': feedback,
      };

      // Send the complaint data to the server
      final Uri uri = Uri.parse(
          "http://10.0.2.2/TuitionGiggle/appData/add_data/insert_complaints.php");
      final response = await http.post(
          uri,
          body: json.encode(complaintData));

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
    static Future submitTask(
    GlobalKey<FormState> formKey,
    BuildContext context,
    String tuitionID,
    String classID,
    String subject,
    String task) async {

      // Validate the form before proceeding
      if (!formKey.currentState!.validate()) {
        return;
      }

      try {
        // Prepare the data to send to the server
        Map<String, String> taskData = {
          'tuitionID': tuitionID,
          'classID': classID,
          'subject': subject,
          'task': task,
        };

        // Send the task data to the server
        final Uri uri = Uri.parse("http://10.0.2.2/TuitionGiggle/appData/add_data/insert_tasks.php");

        // Send the task data to the server as a POST request
        final response = await http.post(
          uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode(taskData),
        );

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
