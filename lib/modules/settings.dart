import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/login_shop_screen/login.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/networks/local/cash_helper.dart';
import 'package:social_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var nameController = TextEditingController();
        var emailController = TextEditingController();
        var phoneController = TextEditingController();
        var cubit = ShopLayoutCubit.get(context);
        if (cubit.userData != null) {
          nameController.text = cubit.userData!.data!.name;
          emailController.text = cubit.userData!.data!.email;
          phoneController.text = cubit.userData!.data!.phone;
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
               if (state is UpdateUserDataLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 10,),
                defaultTextFormField(
                    control: nameController,
                    labelText: "Name",
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) return "name must not be empty";
                    },
                    colorOfLabel: Colors.grey,
                    colorOfFocusedBorder: Colors.grey,
                    keyboard: TextInputType.name,
                    colorOfPrefixIcon: Colors.grey),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                    control: emailController,
                    labelText: "Email Address",
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) return "email must not be empty";
                    },
                    colorOfLabel: Colors.grey,
                    colorOfFocusedBorder: Colors.grey,
                    keyboard: TextInputType.emailAddress,
                    colorOfPrefixIcon: Colors.grey),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                    control: phoneController,
                    labelText: "Phone",
                    prefixIcon: Icons.phone,
                    validator: (value) {
                      if (value!.isEmpty) return "phone must not be empty";
                    },
                    colorOfLabel: Colors.grey,
                    colorOfFocusedBorder: Colors.grey,
                    keyboard: TextInputType.phone,
                    colorOfPrefixIcon: Colors.grey),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    CashHelper.removeData('taken');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginShop(),));
                  },
                  child: Text(
                    "LOGOUT",
                    style: TextStyle(color: Colors.white,fontFamily: 'jannah'),
                  ),
                  color: defaultColor,
                  minWidth: double.infinity,
                  height: 50,
                ),
                SizedBox(height: 20,),
                MaterialButton(
                  onPressed: () {
                    cubit.updateUserData(context: context,data: {
                      'name': nameController.text,
                      "phone": phoneController.text,
                      "email": emailController.text,
                    });

                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(color: Colors.white,fontFamily: 'jannah'),
                  ),
                  color: defaultColor,
                  minWidth: double.infinity,
                  height: 50,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
