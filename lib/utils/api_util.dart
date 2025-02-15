import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_browser/app/domain/entities/api_response/api_response.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/core/enum/http_method_enum.dart';
import 'package:movie_browser/utils/app_logger.dart';
import 'package:movie_browser/utils/env_config.dart';

class ApiUtil {
  final http.Client httpClient;

  ApiUtil({required this.httpClient});

  Future<ApiResponse> makeApiRequest(String endpoint,
      {HttpMethodEnum method = HttpMethodEnum.get,
      Map<String, String>? queryParameters,
      Map<String, String>? headers,
      dynamic body}) async {
    final Uri uri = Uri.parse('${EnvConfig.apiBaseUrl}$endpoint').replace(
      queryParameters: queryParameters,
    );

    final allHeaders = {
      'Authorization': 'Bearer ${EnvConfig.bearerToken}',
      'accept': 'application/json',
      ...(headers ?? {}),
    };

    try {
      http.Response response;

      switch (method) {
        case HttpMethodEnum.get:
          response = await httpClient.get(uri, headers: allHeaders);
          break;
        case HttpMethodEnum.post:
          response =
              await httpClient.post(uri, headers: allHeaders, body: body);
          break;
        case HttpMethodEnum.put:
          response = await httpClient.put(uri, headers: allHeaders, body: body);
          break;
        case HttpMethodEnum.delete:
          response = await httpClient.delete(uri, headers: allHeaders);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        AppLogger.i('API request successful for: $endpoint',
            stackTrace: StackTrace.current);
        return ApiResponse(
            statusCode: response.statusCode,
            responseBody: jsonDecode(response.body),
            reasonPhrase: response.reasonPhrase);
      } else {
        AppLogger.e(
            'Error with API request for $endpoint: ${response.reasonPhrase} '
            '(${response.statusCode})',
            stackTrace: StackTrace.current);
        throw ServiceException(response.reasonPhrase ?? 'Unknown error',
            statusCode: response.statusCode);
      }
    } on SocketException {
      throw NetworkException('No internet connection');
    } on ServiceException {
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
