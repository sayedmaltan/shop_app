import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

import '../modules/search/searchh.dart';

class Shoplayout extends StatelessWidget {
  const Shoplayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit =ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search(),));
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body:cubit.startHomeScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeCurrentIndex(value);
              if(value==2)
                ShopLayoutCubit.get(context).getFavoriteData();
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: "Categories",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favorite"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings"
              ),
            ],
          ),
        );
      },
    );
  }
}
