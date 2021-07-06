import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(

        //base url : https://newsapi.org
        //api key: 89d27f0266e94ba2886ed9742cd89a09
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true));
  }

 static  Future<Response> getData ({@required String url , @required Map<String,dynamic> query}) async{
   return await  dio.get(url , queryParameters: query);
  }
}
