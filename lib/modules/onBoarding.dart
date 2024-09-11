import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'login_shop_screen/login.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  var controller = PageController();
  bool isLast = false;
  late List<BoardingShopAPP> list = [
    BoardingShopAPP(
        "assets/images/deep.png", "On Board 1 Title", "On Board 1 Body"),
    BoardingShopAPP(
        "assets/images/myPhoto.jpeg", "On Board 2 Title", "On Board 2 Body"),
    BoardingShopAPP(
        "assets/images/deep1.png", "On Board 3 Title", "On Board 3 Body")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginShop(),
                    ));
              },
              child: const Text(
                "SKIP",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        body: PageView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) =>
              boardingOfShopAPP(context, controller, list[index], isLast),
          controller: controller,
          itemCount: list.length,
          onPageChanged: (value) {
            setState(() {
              value == list.length - 1 ? isLast = true : isLast = false;
            });
          },
        ));
  }
}

class BoardingShopAPP {
  late String assets;
  late String boardTitle;
  late String boardBody;

  BoardingShopAPP(this.assets, this.boardTitle, this.boardBody);
}
