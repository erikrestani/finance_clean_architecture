import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = 'An error occurred';
    
    if (err.response != null) {
      switch (err.response!.statusCode) {
        case 400:
          message = 'Bad request';
          break;
        case 401:
          message = 'Unauthorized';
          break;
        case 403:
          message = 'Forbidden';
          break;
        case 404:
          message = 'Not found';
          break;
        case 409:
          message = 'Conflict';
          break;
        case 500:
          message = 'Internal server error';
          break;
        default:
          message = 'Network error';
      }
    } else if (err.type == DioExceptionType.connectionTimeout) {
      message = 'Connection timeout';
    } else if (err.type == DioExceptionType.receiveTimeout) {
      message = 'Receive timeout';
    } else if (err.type == DioExceptionType.connectionError) {
      message = 'No internet connection';
    }
    
    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: message,
    );
    
    handler.next(customError);
  }
} 