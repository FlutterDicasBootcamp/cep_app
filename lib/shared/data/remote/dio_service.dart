import 'dart:developer';
import 'dart:io';

import 'package:cep_app/shared/const/const_strings.dart';
import 'package:cep_app/shared/data/async/either.dart';

import 'package:cep_app/shared/data/models/api_response_model.dart';

import 'package:cep_app/shared/data/remote/errors/api_exception.dart';
import 'package:dio/dio.dart';

import 'api_service.dart';

final class DioService implements ApiService {
  final Dio _dio;

  DioService(this._dio);

  @override
  Future<Either<ApiException, ApiResponseModel>> get<T>(String endPoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final Response(:data, :statusCode, :statusMessage) =
          await _dio.get(endPoint, queryParameters: queryParams);

      return Right(
        ApiResponseModel<T>(
          data: data,
          statusCode: statusCode,
          message: statusMessage,
        ),
      );
    } on SocketException catch (error, st) {
      const identifier = "Socket Exception on Get Request";

      log(identifier, error: error, stackTrace: st);

      return Left(
        ApiException(
          identifier: identifier,
          statusCode: 1,
          errorStatus: ErrorStatus.noConnection,
          message: ConstStrings.kNoInternetConnectionMessage,
        ),
      );
    } on DioException catch (dioError, st) {
      const identifier = "DioException on Get Request";

      log(identifier, error: dioError, stackTrace: st);

      return Left(
        ApiException(
          identifier: identifier,
          statusCode: dioError.response?.statusCode,
          errorStatus: dioError.type == DioExceptionType.connectionError
              ? ErrorStatus.noConnection
              : switch (dioError.response?.statusCode) {
                  400 => ErrorStatus.badRequest,
                  500 => ErrorStatus.internalServerError,
                  401 || 403 => ErrorStatus.unauthorized,
                  _ => ErrorStatus.unknown,
                },
          message: dioError.response?.data?['message'] ??
              ConstStrings.kDefaultErrorMessage,
        ),
      );
    } catch (e, st) {
      const identifier = "GenericException on Get Request";

      log(identifier, error: e, stackTrace: st);

      return Left(
        ApiException(
          identifier: identifier,
          statusCode: 3,
          errorStatus: ErrorStatus.unknown,
          message: ConstStrings.kDefaultErrorMessage,
        ),
      );
    }
  }
}
