import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/search/cubit/search_cubit.dart';
import 'package:social_app/modules/search/cubit/search_states.dart';
import 'package:social_app/shared/componants/componants.dart';

import '../../layout/cubit/cubit.dart';
import '../../model/shop_login/favorite_model.dart';
import '../../shared/styles/colors.dart';

class Search extends StatelessWidget {
   Search({super.key});
  var controller=TextEditingController();
  var Key=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        builder: (BuildContext context, SearchStates state) {
        bool isSubmit=false;
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                      control: controller,
                      labelText: "Search",
                      prefixIcon: Icons.search,
                      validator: (value) {
                        if(value!.isEmpty)
                          return" enter word to search";
                      },
                  onFieldSubmitted: (newValue) {
                    SearchCubit.get(context).search(newValue);
                    isSubmit=true;
                  },
                    colorOfPrefixIcon: Colors.grey,
                    colorOfLabel: Colors.grey,
                    colorOfSuffixIcon: Colors.grey,
                  ),
                    SizedBox(height: 15,),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                  if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildFavItem(SearchCubit.get(context).searchModel?.data?.data[index],context),
                          separatorBuilder: (context, index) => Container(height: 1,color: Colors.grey[300],),
                          itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data.length),
                    ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {

        },
      ),
    );
  }

   Widget buildFavItem( model,context){
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


