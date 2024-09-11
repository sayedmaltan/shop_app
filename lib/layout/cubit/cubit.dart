import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/categories.dart';
import 'package:social_app/modules/favorite.dart';
import 'package:social_app/modules/home.dart';
import 'package:social_app/modules/settings.dart';
import 'package:social_app/shared/componants/componants.dart';
import 'package:social_app/shared/componants/constants.dart';
import 'package:social_app/shared/networks/local/cash_helper.dart';
import 'package:social_app/shared/styles/colors.dart';
import '../../model/shop_login/categories.dart';
import '../../model/shop_login/edit_favorite_model.dart';
import '../../model/shop_login/favorite_model.dart';
import '../../model/shop_login/home_layout.dart';
import '../../model/shop_login/shop_login.dart';
import '../../shared/networks/remote/dio_helper.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>
{
  ShopLayoutCubit() :super(ShopLayoutInitialState());
  int currentIndex=0;
  HomeLayout? homeModel;
  CategoriesModel ?categoryModel;
  FavoritesModel ?favoritesModel;
  EditFavoriteModel ?editFav;
  Map<int,bool> favorites={};
  List<Widget> startHomeScreen=[
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];
  Color ?colorOfFavorites;
  static ShopLayoutCubit get(context)
  {
    return BlocProvider.of(context);
  }

  void changeCurrentIndex(index)
  {
    currentIndex=index;
    emit(ChangeBottomNavBarState());
  }
  
  void getHomeData()
  {
    emit(HomeShopLoadingState());
    DioHelper.getData(path: "home",lang: 'en',taken: taken).then((onValue){
    emit(HomeShopSuccessState());
    homeModel=HomeLayout(onValue.data);
    homeModel?.data?.products.forEach((value){
      favorites.addAll({value.id:value.in_favorites});
    });
    }).catchError((onError){
      HomeShopErrorState();
      print(onError.toString());
    });
  }

  void getCategoryData()
  {
    DioHelper.getData(path: "categories",lang: 'en').then((onValue){
      emit(CategoryShopSuccessState());
      categoryModel=CategoriesModel(onValue.data);
      print(categoryModel?.data!.data?[0].name);
    }).catchError((onError){
      emit(CategoryShopErrorState());
      print(onError.toString());
    });
  }

  Color getColorOfFavorite(/*ProductsClass*/ model)
  {
   if(favorites[model.id]==true) {
     return defaultColor;
   } else {
     return Colors.grey;
   }
  }

  void addOrDeleteFavorite({required int id,required EditFavoriteModel? favoriteModel,lang})
  {
    favorites[id]=!favorites[id]!;
    emit(FavoriteEditSuccessState());
    DioHelper.postData(path: "favorites",data: {'product_id':id},taken: taken,lang: lang).
    then((value) {
      editFav=EditFavoriteModel(value.data);
      if(editFav?.status==false) {
        favorites[id]=!favorites[id]!;
        defaultToast(favoriteModel?.message, Colors.red);
      }
      else
        {
          getFavoriteData();
        }
      emit(FavoriteEditSuccessState());
    },).
    catchError((onError){
      favorites[id]=!favorites[id]!;
      print(onError.toString());
      emit(FavoriteEditErrorState());
    })
    ;
  }

  void getFavoriteData()
  {
    emit(FavoriteLoadingState());
    DioHelper.getData(path: "favorites",lang: 'en',taken: taken).then((onValue){
      emit(FavoriteSuccessState());
      favoritesModel=FavoritesModel.fromJson(onValue.data);
    }).catchError((onError){
      FavoriteErrorState();
      print(onError.toString());
    });
  }

  ShopLoginModel ?userData;
  void getUserData()
  {
    emit(UserDataLoadingState());
    DioHelper.getData(path: "profile",lang: 'en',taken: taken).then((onValue){
      emit(UserDataSuccessState());
      userData=ShopLoginModel(onValue.data);
    }).catchError((onError){
      UserDataErrorState();
      print(onError.toString());
    });
  }

  void updateUserData({required context,required data})
  {
    emit(UpdateUserDataLoadingState());
    DioHelper.putData(path: "update-profile",lang: 'en',taken: taken,data: data).then((onValue){
      emit(UpdateUserDataSuccessState());
      userData=ShopLoginModel(onValue.data);
      print(userData?.message);
    }).catchError((onError){
      emit(UpdateUserDataErrorState());
      print(onError.toString());
    });
  }
}