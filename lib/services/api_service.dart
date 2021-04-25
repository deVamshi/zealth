import 'package:dio/dio.dart';

class ApiService {
  static postSymptoms(Map<String, dynamic> listOfSymptomsWithSeverity) async {
    Dio _dio = Dio();

    Map<String, dynamic> body = {
      "symptoms": listOfSymptomsWithSeverity,
      "user-id": 123
    };

    String url = 'https://localhost:8080';

    try {
      Response response = await _dio.post(url, data: body);
      if (response.statusCode == 200) {
        print("Success");
        //TODO : Do something if this is success
      }
    } catch (e) {
      print(e);
    } finally {
      _dio.close();
    }
  }
}
