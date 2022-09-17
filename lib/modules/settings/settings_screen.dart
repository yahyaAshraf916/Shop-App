import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/shop_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constans.dart';


class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
    
        if (state is ShopSuccessUpdateUserDataState) {
          showToast(
              text: 'User Information Updated Successfully ',
              state: ToastStates.SUCCSESS);
        }
        if (state is ShopErrorUpdateUserDataState) {
          showToast(
              text: 'User Information don\'t Updated',
              state:ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        phoneController.text = model.data!.phone!;
        emailController.text = model.data!.email!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserDataState)
                    LinearProgressIndicator(),
                  defulteditTextx(
                    Controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "name must be empty";
                      } else {
                        return null;
                      }
                    },
                    Label: "Name",
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defulteditTextx(
                      Controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "email must be empty";
                        } else {
                          return null;
                        }
                      },
                      Label: "Email",
                      prefix: Icons.email),
                  SizedBox(
                    height: 20,
                  ),
                  defulteditTextx(
                      Controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "phone must be empty";
                        } else {
                          return null;
                        }
                      },
                      Label: "Phone",
                      prefix: Icons.phone),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()&&
                            nameController.text!=null&&
                            emailController.text != null&&
                            phoneController.text != null) {
                          ShopCubit.get(context).updateuserdata(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                      text: "Update"),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: "Logout")
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
