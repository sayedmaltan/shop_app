import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/modules/register_shop_screen/register_cubit/register_screen_cubit.dart';
import 'package:social_app/modules/register_shop_screen/register_cubit/states.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/networks/local/cash_helper.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../layout/ShopLayout.dart';
import '../../shared/componants/constants.dart';
import '../home.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is SuccessRegisterScreen) {
            if (ShopRegisterCubit.get(context).registerModel!.status) {
              print("11111111111111111111111");
              CashHelper.setData(
                'taken',
                ShopRegisterCubit.get(context).registerModel?.data?.token,
              ).then((value) {
                taken = CashHelper.getData('taken');
                defaultToast(
                    ShopRegisterCubit.get(context).registerModel?.message,
                    Colors.red);
                ShopLayoutCubit.get(context).getUserData();
                ShopLayoutCubit.get(context).getHomeData();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Shoplayout(),
                    ));
              });
            } else {
              print("33333333333333333333333");
              defaultToast(
                  ShopRegisterCubit.get(context).registerModel?.message,
                  Colors.red);
            }
          }
        },
        builder: (context, state) {
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
                          'REGISTER',
                          style: TextStyle(
                            fontFamily: 'jannah',
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            colorOfLabel: Colors.grey,
                            control: nameController,
                            keyboard: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            labelText: 'User Name',
                            prefixIcon: Icons.person,
                            colorOfPrefixIcon: Colors.grey),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                            colorOfLabel: Colors.grey,
                            control: emailController,
                            keyboard: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                            },
                            labelText: 'Email Address',
                            prefixIcon: Icons.email_outlined,
                            colorOfPrefixIcon: Colors.grey),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                            colorOfLabel: Colors.grey,
                            colorOfSuffixWithButton: Colors.grey,
                            control: passwordController,
                            keyboard: TextInputType.visiblePassword,
                            suffixIconWithButton:
                                ShopRegisterCubit.get(context).suffix,
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            switchEyeIcon: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validator: (value) {
                              if (value!.length < 8) {
                                return 'password should be at least 8 character';
                              }
                            },
                            labelText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            colorOfPrefixIcon: Colors.grey),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                            colorOfLabel: Colors.grey,
                            control: phoneController,
                            keyboard: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            labelText: 'Phone',
                            prefixIcon: Icons.phone,
                            colorOfPrefixIcon: Colors.grey),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingRegisterScreen,
                          builder: (context) => MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            color: defaultColor,
                            child: Text(
                              "REGISTER",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print(emailController.text);
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
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
