import 'package:flutter/material.dart';

class CardWithTitle extends StatelessWidget {
  final String title;
  const CardWithTitle({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 50,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)),
        elevation: 30,
        child: SizedBox(
          height: 500,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
