import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CardItem extends StatelessWidget {
  final String desc;
  final String img;
  final Color color;
  final VoidCallback function;
  const CardItem({required this.desc, required this.img, required this.color, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: color,
          elevation: 10,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(img,
                width: 90,
                  height: 90,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    desc,
                    style: GoogleFonts.antic(
                      textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20
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