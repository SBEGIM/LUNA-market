import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:haji_market/src/core/constant/localization/localization.dart';
import 'package:haji_market/src/core/rest_client/src/dio_rest_client/rest_client_dio.dart';
import 'package:haji_market/src/core/rest_client/src/dio_rest_client/src/dio_client.dart';

/// Rest client that uses `Dio` as HTTP library.
final class RestClientDio extends RestClientBase {
  RestClientDio({required this.baseUrl, required this.dioClient}) : super(baseUrl: baseUrl);
  final DioClient dioClient;
  final String baseUrl;

  /// Send [Dio] request
  @override
  @protected
  @visibleForTesting
  Future<Map<String, Object?>> send({
    required String path,
    required String method,
    Object? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
    bool returnFullData = false,
  }) async {
    try {
      final response = await dioClient.dio.fetch(
        RequestOptions(
          path: path,
          baseUrl: baseUrl,
          data: body,
          headers: headers,
          method: method,
          contentType: 'application/json',
          responseType: ResponseType.json,
          queryParameters: queryParams,
          sendTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          connectTimeout: const Duration(milliseconds: 30000),
        ),
      );

      final resp = await decodeResponse(
        response.data,
        statusCode: response.statusCode,
        returnFullData: returnFullData,
      );

      if (resp == null) {
        throw WrongResponseTypeException(
          message: 'Unexpected response body type: ${body.runtimeType}',
          statusCode: response.statusCode,
        );
      }
      return resp;
    } on RestClientException {
      rethrow;
    } on DioException catch (e) {
      if ([
        DioExceptionType.connectionError,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
      ].contains(e.type)) {
        Error.throwWithStackTrace(
          ConnectionException(
            message: Localization.currentLocalizations.checkConnectionRetry,
            statusCode: e.response?.statusCode,
            cause: e,
          ),
          e.stackTrace,
        );
      }

      if (e.response != null) {
        final result = await decodeResponse(
          e.response?.data,
          statusCode: e.response?.statusCode,
          returnFullData: returnFullData,
        );

        if ((e.response?.data.toString().contains('<!DOCTYPE html>') ?? false) ||
            (e.response?.data.toString().contains('html>') ?? false)) {
          throw CustomBackendException(
            message: 'Backend returned HTML page. Error: ${e.message}',
            cause: result ?? {},
            statusCode: e.response?.statusCode,
            reset: _isNeedReset(e),
          );
        } else {
          throw CustomBackendException(
            message: e.message ?? 'Backend returned custom error',
            cause: result ?? {},
            statusCode: e.response?.statusCode,
            reset: _isNeedReset(e),
          );
        }
      }
      Error.throwWithStackTrace(
        ClientException(
          message:
              (e.response?.data as Map<String, dynamic>?)?['message'] as String? ??
              e.message ??
              'Client exception',
          statusCode: e.response?.statusCode,
          cause: e,
          reset: _isNeedReset(e),
        ),
        e.stackTrace,
      );
    } on Object catch (e, stack) {
      Error.throwWithStackTrace(ClientException(message: e.toString(), cause: e), stack);
    }
  }

  @override
  Future<Map<String, Object?>> delete(
    String path, {
    Map<String, Object?>? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
    bool returnFullData = false,
  }) => send(
    path: path,
    body: body,
    method: 'DELETE',
    headers: headers,
    queryParams: queryParams,
    returnFullData: returnFullData,
  );

  @override
  Future<Map<String, Object?>> get(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
    bool returnFullData = false,
  }) => send(
    path: path,
    method: 'GET',
    headers: headers,
    queryParams: queryParams,
    returnFullData: returnFullData,
  );

  @override
  Future<Map<String, Object?>> patch(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
    bool returnFullData = false,
  }) => send(
    path: path,
    method: 'PATCH',
    body: body,
    headers: headers,
    queryParams: queryParams,
    returnFullData: returnFullData,
  );

  @override
  Future<Map<String, Object?>> post(
    String path, {
    required Object? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
    bool returnFullData = false,
  }) => send(
    path: path,
    method: 'POST',
    body: body,
    headers: headers,
    queryParams: queryParams,
    returnFullData: returnFullData,
  );

  @override
  Future<Map<String, Object?>> put(
    String path, {
    required Object? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
    bool returnFullData = false,
  }) => send(
    path: path,
    method: 'PUT',
    body: body,
    headers: headers,
    queryParams: queryParams,
    returnFullData: returnFullData,
  );

  // <-- Additional methods -->

  bool _isNeedReset(DioException error) {
    try {
      if (error.response != null &&
          error.response!.data != null &&
          error.response!.data is Map<String, dynamic>) {
        final responseDataMap = error.response!.data as Map<String, dynamic>;

        return (((responseDataMap['data'] as Map<String, dynamic>?)?['reset'] as List?) ?? [])
            .isNotEmpty;
      }

      return false;
    } catch (_) {
      return false;
    }
  }
}
