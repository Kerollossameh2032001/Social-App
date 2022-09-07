import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/modules/login/cubit/cubit.dart';
import 'package:social_app1/modules/login/cubit/states.dart';
import 'package:social_app1/modules/register/register_screen.dart';
import 'package:social_app1/shared/cache_helper/cache_helper.dart';
import 'package:social_app1/shared/components/colors_style.dart';
import 'package:social_app1/shared/components/constant.dart';
import 'package:social_app1/shared/components/icon_broken.dart';
import '../../layout/layout_screen.dart';
import '../../shared/components/register_&_login_widgets/CustomTitle.dart';
import '../../shared/components/register_&_login_widgets/card_with_title.dart';
import '../../shared/components/register_&_login_widgets/google_icon_button.dart';
import '../../shared/components/register_&_login_widgets/register_or_login_choice.dart';
import '../../shared/components/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginWithEmailAndPasswordSuccesState) {
            CacheHelper.setData(key: 'uId', value: state.uId).then((value) {
              savedUId = state.uId;
              navigateAndReplacement(context, LayoutScreen());
            });
          }
          if (state is LoginWithEmailAndPasswordErrorState) {
            showToast(message: state.error);
          }
          if (state is LoginCreateUserSuccesState) {
            CacheHelper.setData(key: 'uId', value: state.uId).then((value) {
              savedUId = state.uId;
              navigateAndReplacement(context, LayoutScreen());
            });
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomTitle(title: 'SOCIAL APP'),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          //Background Layout
                          Align(
                            alignment: const Alignment(2, 1),
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: defaultGradient),
                            ),
                          ),
                          Positioned(
                            top: 425,
                            left: -60,
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: defaultGradient),
                            ),
                          ),
                          const CardWithTitle(title: 'SIGN IN'),
                          //TextFormField Layout
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 200.0, left: 60),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 240,
                                    child: TextFormField(
                                      controller: emailController,
                                      cursorColor: defaultColor,
                                      decoration: const InputDecoration(
                                          label: Text('Email address'),
                                          prefixIcon:
                                              Icon(Icons.email_outlined)),
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
                                  const SizedBox(height: 25),
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
                                          return 'The password must not be empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  CustomButton(
                                      title: 'LOGIN',
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.logInWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context,
                                          );
                                        }
                                      }),
                                  const SizedBox(height: 25),
                                  Text(
                                    "Or Sign With",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  const SizedBox(height: 25),
                                  GoogleIconButton(onPressed: () {
                                    cubit.loginWithGoogleAccount(
                                        context: context);
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 75),
                      RegisterOrLoginChoice(
                        state: 'New one ?',
                        choice: 'Sign Up Here',
                        action: () {
                          navigateTo(context, RegisterScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
