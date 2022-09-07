import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'colors_style.dart';

void navigateTo(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}

void navigateAndReplacement(BuildContext context, Widget widget) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: defaultGradient,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

void showToast({
  required String message,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: defaultColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
