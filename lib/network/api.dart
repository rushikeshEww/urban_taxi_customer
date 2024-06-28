import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class Api {

  final Dio dio = Dio();

  Api() {
    _configureDio();
  }

  void _configureDio() {
    dio.options = BaseOptions(
      baseUrl: "https://dev.urban-nl.app/api/customer/",
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Accept-Language'] = 'en';
          options.headers['KEY'] = 'UrbaanTaxi@1234';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response); // continue
        },
      )
    );
  }

  Future<Map<String, dynamic>> apiCall(String url,
     Map<String, dynamic>? body, RequestType requestType) async {
    late  Response result;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.mobile) && !connectivityResult.contains(ConnectivityResult.wifi)) {
      return {
        "status" : false,
        "message" : "Please check your network"
      };
    }
    try {
      switch (requestType) {
        case RequestType.GET: {
          result = await dio.get(url);
          break;
        }
        case RequestType.POST: {
          result = await dio.post( url, data: body);
          break;
        }
        case RequestType.DELETE: {
          result = await dio.delete( url);
          break;
        }
      }
      return result.data;
    } on DioError catch (error) {
      print(error.message);
      return {
        "status" : false,
        "message" : error.message
      };
    } catch (error) {
      return {
        "status" : false,
        "message" : "Something went wrong"
      };
    }
  }

}

enum RequestType {
  GET, POST, DELETE
}