import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/modules/login/Login_Screen.dart';
import 'package:social_app1/modules/register/register_form_field.dart';
import 'package:social_app1/shared/components/colors_style.dart';
import 'package:social_app1/shared/components/icon_broken.dart';
import 'package:social_app1/shared/components/register_&_login_widgets/register_or_login_choice.dart';
import '../../layout/layout_screen.dart';
import '../../shared/cache_helper/cache_helper.dart';
import '../../shared/components/constant.dart';
import '../../shared/components/register_&_login_widgets/CustomTitle.dart';
import '../../shared/components/register_&_login_widgets/card_with_title.dart';
import '../../shared/components/register_&_login_widgets/google_icon_button.dart';
import '../../shared/components/widgets.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterCreateUserSuccesState){
            CacheHelper.setData(key: 'uId', value: state.uId).then((value){
              savedUId = state.uId;
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LayoutScreen()));
            });
          }
        },
        builder: (context, states) {
          RegisterCubit cubit = RegisterCubit.get(context);
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
                          const CardWithTitle(title: 'SIGN UP'),
                          //TextFormField Layout
                          RegisterForm(
                              formKey: formKey,
                              nameController: nameController,
                              emailController: emailController,
                              phoneController: phoneController,
                              passwordController: passwordController,
                              cubit: cubit,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 65),
                        child: RegisterOrLoginChoice(
                          state: 'Already a Member ?',
                          choice: 'Sign In Here',
                          action: () {
                            navigateTo(context, LoginScreen());
                          },
                        ),
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
