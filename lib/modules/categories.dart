import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import '../model/shop_login/categories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>
      (
      listener: (context, state) {},
        builder: (context, state) {
         return ConditionalBuilder(
             condition: ShopLayoutCubit.get(context).categoryModel!=null,
             builder: (context) => BuildCategory(context,ShopLayoutCubit.get(context).categoryModel),
             fallback: (context) => Center(child: CircularProgressIndicator()),);
        },

    );
  }

  Widget BuildCategory(context,CategoriesModel? model){
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => BuildCatItem(model!.data!.data![index]),
          separatorBuilder: (context, index) => Container(
          height: 1,
          color: Colors.grey[200],
          ),
          itemCount: model!.data!.data!.length),
    );
  }
  Widget BuildCatItem(DataModel model){
    return Row(
      children: [
        Image(
        image: NetworkImage(model.image),
        height: 80,
        width: 80,
        ),
        SizedBox(width: 10,),
        Text("${model.name}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        Spacer(),
        IconButton(onPressed: () {},
        icon: Icon(Icons.arrow_forward_ios))
      ],
    );
  }
}