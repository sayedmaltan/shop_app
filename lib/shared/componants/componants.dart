import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/modules/login_shop_screen/login.dart';
import 'package:social_app/shared/styles/colors.dart';
import '../../modules/onBoarding.dart';

Widget boardingOfShopAPP(context,PageController controller, BoardingShopAPP list,bool isLast)=> Padding(
  padding: const EdgeInsets.all(35.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Expanded(
        child: Image(
          image: AssetImage(list.assets),
        ),
      ),
      const SizedBox(
        height: 45,
      ),
       Text(
        '${list.boardTitle}',
        style: const TextStyle(
          fontFamily: "jannah",
          fontSize: 24,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
       Text('${list.boardBody}',
          style: const TextStyle(
            fontFamily: "jannah",
            fontSize: 16,
          )),
      const SizedBox(
        height: 80,
      ),
      Row(
        children: [
          SmoothPageIndicator(
              controller: controller,  // PageController
              count:  3,
              effect:   WormEffect(
                activeDotColor: defaultColor,
              ),
// your preferred effect
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              controller.nextPage(
                  duration: const Duration(
                    milliseconds: 1050,
                  ), curve: Curves.fastEaseInToSlowEaseOut);
              if(isLast==true) {
                Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginShop(),
              ),
              );
              }

            },
            child: const Icon(Icons.arrow_forward_ios),
          )
        ],
      )
    ],
  ),
);

Widget defaultTextFormField({
  required TextEditingController control,
  required String labelText,
  required IconData prefixIcon,
  IconData? suffixIconWithButton,
  IconData? suffixIcon,
  TextInputType? keyboard,
  required String? Function(String? value) validator,
  bool isPassword = false,
  void Function()? switchEyeIcon,
  ValueChanged<String>? onChange,
  FormFieldSetter<String>? onFieldSubmitted,
  Function()? onTap,
  bool showCursor=true,
  bool readOnly=false,
  Color colorOfEnabledBorder=Colors.grey,
  Color colorOfFocusedBorder=Colors.grey,
  Color? colorOfInputText,
  Color? colorOfPrefixIcon,
  Color? colorOfLabel,
  Color? colorOfSuffixWithButton,
  Color? colorOfSuffixIcon,
  double suffixIconButtonOpecity=1,
  FontWeight? weightOfLable,
  var key,
}) => TextFormField(
      validator: validator,
      controller: control,
      key: key,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorOfEnabledBorder)
        ),
        focusedBorder:   OutlineInputBorder(
          borderSide: BorderSide(color: colorOfFocusedBorder),
        ),
        border:  const OutlineInputBorder(
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: colorOfPrefixIcon,
        ),
        suffixIcon: (suffixIcon==null)?
        IconButton(
          icon: Opacity(opacity: suffixIconButtonOpecity,
          child: Icon(suffixIconWithButton)),
          onPressed: switchEyeIcon,
          color: colorOfSuffixWithButton,
        ):
        Icon(
          suffixIcon,
        color: colorOfSuffixIcon,
        ),
        labelStyle: TextStyle(
          color: colorOfLabel,
            fontWeight: weightOfLable,
            fontFamily: "jannah"
        ),
      ),
      style: TextStyle(
        color: colorOfInputText
      ),
      keyboardType: keyboard,
      obscureText: isPassword,
      onTap: onTap,
      showCursor: showCursor,
      readOnly: readOnly,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
    );

Future<bool?> defaultToast(message,backgroundColor) async{
  return await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0
  ).then((onValue){

  }).catchError((onError){
    print(onError.toString());
  });
}
