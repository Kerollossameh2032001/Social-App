import 'package:flutter/material.dart';

class RegisterOrLoginChoice extends StatelessWidget {
  final String state;
  final String choice;
  final void Function()? action;

  const RegisterOrLoginChoice(
      {Key? key,
      required this.choice,
      required this.action,
      required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          state,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 20, height: 0.1),
        ),
        TextButton(
          onPressed: action,
          child: Text(
            choice,
            style: const TextStyle(fontSize: 20, height: 0.1),
          ),
        ),
      ],
    );
  }
}
