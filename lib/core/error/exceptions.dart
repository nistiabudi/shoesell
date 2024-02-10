class ServerException implements Exception {}

class CachedException implements Exception {}

class RouteException implements Exception {
  RouteException({required this.message});
  final String message;
}
