import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'biblioteca.png',
            width: 50,
            height: 50,
          ),

          SizedBox( height: 20 ),

          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Biblioteca Dominica',
              style: GoogleFonts.montserratAlternates(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}