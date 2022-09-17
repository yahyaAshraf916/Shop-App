import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';


class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CachHelper.saveData(
                      key: "token", value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
               
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  state: ToastStates.ERROR, text: state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Register now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defulteditTextx(
                            Controller: namecontroller,
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "name must not be empty";
                              } else {
                                return null;
                              }
                            },
                            Label: 'enter your name',
                            prefix: Icons.person),
                       const SizedBox(
                          height: 20,
                        ),
                        defulteditTextx(
                            Controller: phonecontroller,
                            keyboardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "phone must not be empty";
                              } else {
                                return null;
                              }
                            },
                            Label: 'enter your phone',
                            prefix: Icons.phone),
                       
                       const SizedBox(
                          height: 20,
                        ),
                        defulteditTextx(
                            Controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "email must not be empty";
                              } else {
                                return null;
                              }
                            },
                            Label: 'enter your email',
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 20,
                        ),
                        defulteditTextx(
                            Controller: passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "password must not be empty";
                              } else {
                                return null;
                              }
                            },
                            Label: 'enter your password',
                            prefix: Icons.lock_outlined,
                            suffix: cubit.suffix,
                            isPassword: cubit.isPassword,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            },
                          ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text, name: namecontroller.text,
                                      phone: phonecontroller.text);
                                }
                              },
                              text: "register",
                              isUpperCase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Do you have an account ?"),
                            defaultTextButton(
                                function: () {
                                navigateTo(context, ShopLoginScreen());
                                },
                                text: "Login")
                          ],
                        )
                      ],
                    ),
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
