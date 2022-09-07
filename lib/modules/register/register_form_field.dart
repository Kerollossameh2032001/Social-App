import 'package:flutter/material.dart';
import '../../shared/components/colors_style.dart';
import '../../shared/components/icon_broken.dart';
import '../../shared/components/register_&_login_widgets/google_icon_button.dart';
import '../../shared/components/widgets.dart';
import 'cubit/cubit.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.cubit,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final RegisterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150.0, left: 60),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            //Name
            SizedBox(
              width: 240,
              child: TextFormField(
                controller: nameController,
                cursorColor: defaultColor,
                decoration: const InputDecoration(
                    label: Text('Name'), prefixIcon: Icon(Icons.person)),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The name must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            //Email
            SizedBox(
              width: 240,
              child: TextFormField(
                controller: emailController,
                cursorColor: defaultColor,
                decoration: const InputDecoration(
                    label: Text('Email address'),
                    prefixIcon: Icon(Icons.email_outlined)),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The Email must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            //Phone
            SizedBox(
              width: 240,
              child: TextFormField(
                controller: phoneController,
                cursorColor: defaultColor,
                decoration: const InputDecoration(
                    label: Text('Phone'), prefixIcon: Icon(IconBroken.Call)),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The Phone must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            //Password
            SizedBox(
              width: 240,
              child: TextFormField(
                controller: passwordController,
                cursorColor: defaultColor,
                decoration: InputDecoration(
                  label: const Text('Password'),
                  prefixIcon: const Icon(IconBroken.Lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        cubit.changeVisibility();
                      },
                      icon: Icon(cubit.prefix)),
                ),
                obscureText: cubit.obscure,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The Password is too short';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            CustomButton(
                title: 'SIGN UP',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.userRegister(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        password: passwordController.text);
                  }
                }),

            const SizedBox(height: 15),
            Text(
              "Or Sign Up With",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 15),
            GoogleIconButton(onPressed: () {
              cubit.registerWithGoogle();
            }),
          ],
        ),
      ),
    );
  }
}
