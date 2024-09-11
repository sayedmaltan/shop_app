import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/ShopLayout.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/login_shop_screen/login.dart';
import 'package:social_app/shared/componants/constants.dart';
import 'package:social_app/shared/networks/local/cash_helper.dart';
import 'package:social_app/shared/networks/remote/dio_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'firebase_options.dart';
import 'layout/cubit/cubit.dart';
import 'modules/login_shop_screen/cubit/login_screen_cubit.dart';
import 'modules/onBoarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.initDio();
  await CashHelper.init();
  if (CashHelper.getData('taken') != null) taken = CashHelper.getData('taken');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late String name;

  Widget startScreen() {
    if (CashHelper.getData('onboarding') != null &&
        CashHelper.getData('onboarding')) {
      if (CashHelper.getData('taken') != null &&
          CashHelper.getData('onboarding')) return Shoplayout();
      return LoginShop();
    }
    return Onboarding();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ShopLayoutCubit>(
          create: (context) => ShopLayoutCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getFavoriteData()
            ..getUserData(),
        )
      ],
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        builder: (context, state) {
          return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: startScreen());
        },
        listener: (context, state) {},
      ),
    );
  }
}
