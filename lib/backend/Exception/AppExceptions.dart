import 'dart:io';

abstract class AppExceptions {
  final String _message;
  final String _prefix;

  AppExceptions({required String message, required String prefix})
      : _message = message,
        _prefix = prefix;

  @override
  String toString() {
    return "$_prefix :: $_message";
  }
}

class CommunicationException extends AppExceptions {
  CommunicationException({required super.message})
      : super(prefix: "Communication Exception");
}

class NetworkException extends AppExceptions {
  NetworkException({required super.message}) : super(prefix: "Network Error!");
}

class DefaultException extends AppExceptions {
  DefaultException({required super.message})
      : super(prefix: "Something Went Wrong!");
}

String getResponse(HttpResponse response) {
  final statusCode = response.statusCode;
  switch (statusCode) {
    case 200 || 201:
      return "Response";
    case 404:
      throw NetworkException(message: "Please check your mobile network");
    case 500:
      throw CommunicationException(
          message: "Error During Communication! Try again");
    default:
      throw DefaultException(message: "Something Went Wrong Try again later");
  }
}
