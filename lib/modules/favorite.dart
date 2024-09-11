import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import '../layout/cubit/cubit.dart';
import '../model/shop_login/favorite_model.dart';
import '../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      builder: (context, state) => ConditionalBuilder(
        condition: (state is FavoriteLoadingState||ShopLayoutCubit.get(context).favoritesModel==null) ,
        builder: (context) => Center(child: CircularProgressIndicator()),
        fallback: (context) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: ListView.separated(
              itemBuilder: (context, index) => buildFavItem(ShopLayoutCubit.get(context).favoritesModel?.data?.data[index].product,context),
              separatorBuilder: (context, index) => Container(height: 1,color: Colors.grey[300],),
              itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data.length),
        ),
      ),
      listener: (context, state) {
      },
    );
  }

  Widget buildFavItem(Product? model,context){
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20,end: 15,bottom: 15),
      child: Container(
        height: 120,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model?.image}'),
                  width: 120,
                  height: 120,
                ),
                  if (model?.discount!=0)
                  Container(
                      color: Colors.red,
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      )),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     "${model?.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                         "${model?.price}",
                        style: TextStyle(color: defaultColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model?.discount != 0)
                      Text(
                        '1000',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.grey),
                      ),
                      Spacer(),

                      IconButton(
                        onPressed: () {
                          ShopLayoutCubit.get(context).addOrDeleteFavorite(id: model!.id,favoriteModel:ShopLayoutCubit.get(context).editFav,lang:'en');

                        },
                        icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:ShopLayoutCubit.get(context).getColorOfFavorite(model),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 15,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
