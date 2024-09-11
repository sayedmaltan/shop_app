import 'package:dio/dio.dart';

import '../../componants/constants.dart';

class DioHelper{

  static late  Dio dio;

  static void  initDio() {
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // headers: {
        //   'Content-Type':'application/json',
        // }
      ),

    );
  }

  static Future<Response> getData({required path,  query,lang,taken}) async{
    dio.options.headers= {
      'lang':lang,
      'Authorization': taken??'',
      'Content-Type': 'application/json',
    };
   return  await dio.get(
     "$path",
     queryParameters: query,
   ).catchError((onError){
     print(onError.toString());
   });
  }

  static Future<Response> postData({required path, query, Map<String, dynamic>? data,lang,taken}) async  {
dio.options.headers={
  'lang':lang,
  'Authorization':taken??'',
  'Content-Type': 'application/json',
};
    return await dio.post(
      path,
      queryParameters: query,
      data: data
    // {
      //     'email':username,
      //   'password':pass,
      //   "product_id": id,
      // }
    );
}

  static Future<Response> putData({required path, query, Map<String, dynamic>? data,lang,taken}) async  {
    dio.options.headers={
      'lang':lang,
      'Authorization':taken??'',
      'Content-Type': 'application/json',
    };
    return await dio.put(
        path,
        queryParameters: query,
        data: data
      // {
      //     'email':username,
      //   'password':pass,
      //   "product_id": id,
      // }
    );
  }


}