import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CardItem extends StatelessWidget {
  final String desc; // Text displayed
  final String img; // Image displayed
  final Color color; // Background color
  final VoidCallback function; // Trigger callback function

  const CardItem({required this.desc, required this.img, required this.color, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        // Card Widget
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: color,
          // Shadow effect
          elevation: 15,
          child: Center(
            child: Column(
              // Minimal space
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(img,
                width: 85,
                  height: 85,
                ),

                // Description text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    desc,
                    style: GoogleFonts.antic(
                      textStyle: TextStyle(
                        color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}