import 'package:dio/src/response.dart';
import 'api_provider.dart';

class ApiRepository {


  final ApiProvider _provider = ApiProvider(
    baseUrl: 'https://your-api.com/api', // Replace with your API base URL
    headers: {
      'Content-Type': 'application/json', // Example of a default header
      'Accept': 'application/json',
    },
  );


  Future<Response> getProjectsList() {
    return _provider.get("endpoint",);
  }


}

class NetworkError extends Error {}