import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postNotification({
  required Map<String,dynamic> data
}) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'Authorization':'key=AAAAaTFBlOM:APA91bHmOimuwukAOCXE0NaS-ZxgUlOQahVcfNyt5x4DMaDFc4gtmO2i8KoxFHX35VtLSjy_NciIFEEVYfrKqzUY5-oDlKmGthDDijXZU7Ij_h9hZp7k8lzgchCmYSgP5U6r3QZWpXXD'
    };
    return await dio.post('send',data: data);
  }
}
