import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';


class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CachHelper.saveData(
                      key: "token", value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  state: ToastStates.ERROR, text: state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
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
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "login now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
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
                            onSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                                }
                              },
                              text: "login",
                              isUpperCase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Don't have an account ?"),
                            defaultTextButton(
                                function: () {
                                navigateTo(context, ShopRegisterScreen());
                                },
                                text: "Register")
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
