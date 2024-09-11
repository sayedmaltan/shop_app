import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/search/cubit/search_states.dart';
import 'package:social_app/shared/networks/remote/dio_helper.dart';
import '../../../model/shop_login/search_model.dart';
import '../../../shared/componants/constants.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel ?searchModel;
  void search(text){
    emit(SearchLoadingState());
    DioHelper.postData(
      path: 'products/search',
      taken: taken,
      lang: 'en',
      data: {
        "text": text
      }
    ).then((onValue){
      searchModel=SearchModel.fromJson(onValue.data);
      print(searchModel?.data?.currentPage);
      emit(SearchSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SearchErrorState());
    });
  }
}