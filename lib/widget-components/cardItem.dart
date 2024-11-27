import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MainBox extends StatelessWidget {
  final String textDesc; // Text
  final String image; // Image
  final Color backgroundColor; // Background color
  final VoidCallback onTap; // Trigger callback function

  const MainBox({required this.textDesc, required this.image, required this.backgroundColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Code adapted from Yassein, 2020
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Box Widget
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: backgroundColor,
          // Shadow effect
          elevation: 15,

          child: Center(
          child: Column(
            // Minimal space
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(image,
                width: 85,
                height: 85,
              ),

              // Description text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textDesc,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
    // End of adapted code
  }
}

