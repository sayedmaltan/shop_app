import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../model/shop_login/categories.dart';
import '../model/shop_login/home_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).homeModel != null,
          builder: (context) =>
              buildWidget(context, ShopLayoutCubit.get(context).homeModel),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildWidget(context, HomeLayout? model) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model?.data?.banners.map((e) {
              return Image(
                image: NetworkImage(e.image),
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              height: 190,
              initialPage: 0,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategorie(
                          ShopLayoutCubit.get(context)
                              .categoryModel!
                              .data!
                              .data![index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 6,
                          ),
                      itemCount: ShopLayoutCubit.get(context)
                          .categoryModel!
                          .data!
                          .data!
                          .length),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "New Products",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: GridView.count(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 1.7,
                children: List.generate(
                  model!.data!.products.length,
                  (index) =>
                      buildGridView(model.data?.products[index], context),
                )),
          ),
        ],
      ),
    );

Widget buildGridView(ProductsClass? model, context) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model!.image),
              width: double.infinity,
              height: 180,
            ),
            if (model.discount != 0)
              Container(
                  color: Colors.red,
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  )),
          ],
        ),
        Padding(
          padding:
              const EdgeInsetsDirectional.only(start: 12, top: 12, end: 12),
          child: Text(
            model.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text(
                '${model.price.round()}',
                style: TextStyle(color: defaultColor),
              ),
              SizedBox(
                width: 10,
              ),
              if (model.discount != 0)
                Text(
                  '${model.old_price.round()}',
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey),
                ),
              Spacer(),
              IconButton(
                onPressed: () {
                  ShopLayoutCubit.get(context).addOrDeleteFavorite(id: model.id,favoriteModel:ShopLayoutCubit.get(context).editFav,lang:'en');
                },
                icon: CircleAvatar(
                    radius: 15,
                    backgroundColor:
                        ShopLayoutCubit.get(context).getColorOfFavorite(model),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 15,
                    )),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCategorie(DataModel model) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        image: NetworkImage(model.image),
      ),
      Container(
          width: 100,
          color: Colors.black.withOpacity(.8),
          child: Text(
            "${model.name}",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ))
    ],
  );
}
