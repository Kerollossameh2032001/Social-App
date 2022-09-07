import 'package:flutter/material.dart';

class GoogleIconButton extends StatelessWidget {
  final void Function()? onPressed;
  const GoogleIconButton({
    Key? key,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).backgroundColor),
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          children: [
            const Image(
              image: AssetImage(
                  'assets/images/googleIcon.webp'),
              height: 25,
            ),
            const SizedBox(width: 15),
            Text(
              "Google",
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
