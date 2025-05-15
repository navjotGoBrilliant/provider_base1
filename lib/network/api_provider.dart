import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

/// A class to provide a configured Dio client for making API requests.
class ApiProvider {
  static const int _defaultConnectTimeout = 10000; // 10 seconds
  static const int _defaultReceiveTimeout = 10000; // 10 seconds

  final Dio _dio = Dio();

  /// Initializes the ApiProvider with base URL, headers, and interceptors.
  ///
  /// The [baseUrl] is required and should be a valid URL.  [headers] is an
  /// optional map of headers to include in every request.
  ApiProvider({
    required String baseUrl,
    Map<String, String>? headers,
  }) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = Duration(milliseconds: _defaultConnectTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: _defaultReceiveTimeout);

    // Set default headers if provided.
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    _setupInterceptors();
  }

  /// Returns the Dio instance.  This allows for further customization
  /// if needed, but it's generally recommended to use the methods
  /// provided by this class (e.g., [get], [post], etc.).
  Dio get dio => _dio;

  /// Sets up interceptors for the Dio client.
  ///
  /// This includes a logging interceptor for debugging and an interceptor
  /// for handling network connectivity and errors.
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          if (kDebugMode) {
            // Use kDebugMode to avoid including this in release builds
            print('Request: ${options.method} ${options.uri}');
            print('Headers: ${options.headers}');
            print('Data: ${options.data}');
          }

          /// Check for internet connectivity before making the request.
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult == ConnectivityResult.none) {
            /// Use a more specific DioError type
            return handler.reject(DioException(
              requestOptions: options,
              error: 'No internet connection',
              type: DioExceptionType.connectionTimeout, // Or .unknown, if appropriate
            ));
          }

          // Continue with the request
          return handler.next(options);
        },
        onResponse: (Response response, handler) {
          if (kDebugMode) {
            print(
                'Response [${response.statusCode}]: ${response.requestOptions.uri}');
            print('Data: ${response.data}');
          }
          return handler.next(response); // Continue with the response
        },
        onError: (DioException error, handler) {
          if (kDebugMode) {
            print('Dio Error: ${error.type} - ${error.message}');
            if (error.response != null) {
              print('  Response: ${error.response?.statusCode}');
              print('  Data: ${error.response?.data}');
            }
          }

          /// Handle specific error types for a better user experience.
          ///
          String errorMessage = 'An error occurred';
          switch (error.type) {
            case DioExceptionType.cancel:
              errorMessage = 'Request cancelled';
              break;
            case DioExceptionType.connectionTimeout:
              errorMessage = 'Connection timeout';
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = 'Receive timeout';
              break;
            case DioExceptionType.sendTimeout:
              errorMessage = 'Send timeout';
              break;
            case DioExceptionType.badResponse:
            // Handle server errors (4xx, 5xx)
              if (error.response?.statusCode != null) {
                errorMessage =
                'Server error: ${error.response!.statusCode}';
                // You can add more specific error handling based on status code.
                if (error.response!.statusCode == 401) {
                  errorMessage =
                  'Unauthorized. Please log in again.';
                } else if (error.response!.statusCode == 404) {
                  errorMessage = 'Resource not found.';
                } else if (error.response!.statusCode == 500) {
                  errorMessage = 'Internal server error.';
                }
              }
              break;
            case DioExceptionType.unknown:
              if (error.message != null &&
                  error.message!.contains('No internet connection')) {
                errorMessage = 'No internet connection. Please check your network.';
              } else {
                errorMessage = 'Unknown error. Please check your connection.';
              }
              break;
            default:
              errorMessage = 'An unexpected error occurred.';
          }

          /// Wrap the error in a custom exception for easier handling in the UI.
          ///
          return handler.reject(DioException(
            requestOptions: error.requestOptions,
            error: errorMessage, // Use the modified error message
            type: error.type,
          )); // Use the same type
        },
      ),
    );
  }

  /// Performs a GET request.
  ///
  /// [endpoint] is the URL endpoint.  [queryParameters] is an optional map
  /// of query parameters.  [headers] is an optional map of headers.
  Future<Response> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      // Re-throw the error to be handled by the caller.
      throw _handleError(e);
    } finally {
      _resetHeaders(); // Reset headers after the request
    }
  }

  /// Performs a POST request.
  ///
  /// [endpoint] is the URL endpoint.  [data] is the request body.
  /// [headers] is an optional map of headers.
  Future<Response> post(
      String endpoint, {
        dynamic data,
        Map<String, String>? headers,
      }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      throw _handleError(e);
    } finally {
      _resetHeaders();
    }
  }

  /// Performs a PUT request.
  ///
  /// [endpoint] is the URL endpoint.  [data] is the request body.
  /// [headers] is an optional map of headers.
  Future<Response> put(
      String endpoint, {
        dynamic data,
        Map<String, String>? headers,
      }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      throw _handleError(e);
    } finally {
      _resetHeaders();
    }
  }

  /// Performs a DELETE request.
  ///
  /// [endpoint] is the URL endpoint.
  /// [headers] is an optional map of headers.
  Future<Response> delete(
      String endpoint, {
        Map<String, String>? headers,
      }) async {
    try {
      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }
      return await _dio.delete(endpoint);
    } catch (e) {
      throw _handleError(e);
    } finally {
      _resetHeaders();
    }
  }

  /// Handles errors that occur during API requests.
  ///
  /// This method centralizes error handling logic.  It checks for specific
  /// error types and throws a user-friendly exception.
  dynamic _handleError(dynamic error) {
    if (error is DioException) {
      // DioException already has a message.  We might want to log it, though.
      if (kDebugMode) {
        print("Dio Error: ${error.message}");
      }
      throw error; // Re-throw the DioException
    } else {
      // Handle other types of errors (e.g., FormatException, etc.)
      if (kDebugMode) {
        print("Generic Error: $error");
      }
      throw Exception('An unexpected error occurred: $error');
    }
  }

  /// Resets the headers to the default state.  This is important
  /// to prevent headers from leaking between requests.
  void _resetHeaders() {
    _dio.options.headers = {}; // Or, restore to the initial default headers.
  }
}





// class ApiProvider {
//   final Dio _dio = Dio();
//   final String _url = 'http://13.60.231.27:3000/api/';
//
//   Future<ProjectsModel> getProjectsList() async {
//     try {
//       var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJyYW1hbmRlZXBAeW9wbWFpbC5jb20iLCJpYXQiOjE3NDU3NTQ2MDksImV4cCI6MTc0OTM1NDYwOX0.KplJ9ewOYHn0TfgmmRQq9q3m9XW3JnCZh3tK9n10IfM';
//
//       var response = await _dio.get("${_url}project/listAllProjects/false",
//           options: Options(
//             headers: {
//               'Content-Type': 'application/json',
//               'Accept': 'application/json',
//               'Authorization': 'Bearer $token ',
//             },
//           ));
//
//       return ProjectsModel.fromJson(response.data);
//     } catch (error, stacktrace) {
//       print("Exception occurred: $error stackTrace: $stacktrace");
//       return ProjectsModel.withError("Data not found / Connection issue");
//     }
//   }
// }
