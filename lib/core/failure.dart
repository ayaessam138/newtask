import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with Apiserver');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout with Apiserver');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Recive Timeout with Apiserver');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Requset  to Apiserver was Cancelled');

      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure('No internet Connection');
        } else {
          return ServerFailure('Unexcepcted error, Please try Later');
        }
      case DioExceptionType.badCertificate:
        return ServerFailure('Unexcepcted error, Please try Later');

      case DioExceptionType.connectionError:
        return ServerFailure('Unexcepcted error, Please try Later');
    }
  }

  factory ServerFailure.fromResponse(int statuscode, dynamic response) {
    if (statuscode == 400 || statuscode == 401 || statuscode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statuscode == 404) {
      return ServerFailure(' Your Requset Not Found ,Please try again');
    } else if (statuscode == 500) {
      return ServerFailure('Internal Server error ,Please try again');
    } else {
      return ServerFailure('OPPS There is an error, Please Try Again');
    }
  }
}