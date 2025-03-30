import 'package:flutter/material.dart';




class CustomIconButton extends StatelessWidget {
  
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.color = Colors.indigo,
    this.isFilled = false,
  }) : super(key: key);
  
  
  @override
    Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(StadiumBorder()),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return color.withOpacity(0.5);
            }
            return isFilled ? color : null;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return color.withOpacity(0.3);
            }
            return null;
          },
        ),
      ),
      onPressed: onPressed(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
