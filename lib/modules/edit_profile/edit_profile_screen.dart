import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/shared/components/colors_style.dart';
import 'package:social_app1/shared/components/widgets.dart';

import '../../shared/components/icon_broken.dart';
import 'edit_profile_widgets/edit_profile_and_cover_image.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        nameController.text = cubit.userModel!.name;
        bioController.text = cubit.userModel!.bio;
        phoneController.text = cubit.userModel!.phone;
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditProfileAndCoverImages(
                    model: cubit.userModel!,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 8.0),
                    child: Text(
                      'Basic Information',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 5, right: 10, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Full Name",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        TextFormField(
                          controller: nameController,
                          cursorColor: defaultColor,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The name must not be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.name,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Your Bio",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        TextFormField(
                          controller: bioController,
                          cursorColor: defaultColor,
                          maxLines: null,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.info_outlined),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Mobile Number",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        TextFormField(
                          controller: phoneController,
                          cursorColor: defaultColor,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(IconBroken.Call)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "The phone must not be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: CustomButton(
                      title: "Update",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (cubit.userImage != null ||
                              cubit.userCoverImage != null) {
                            cubit.upLoadAndUpdateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              bio: bioController.text,
                            );
                          } else {
                            cubit.updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              image: cubit.userModel!.image,
                              coverImage: cubit.userModel!.coverImage,
                              bio: bioController.text,
                            );
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
