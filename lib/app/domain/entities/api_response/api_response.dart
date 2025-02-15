import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  final int statusCode;
  final dynamic responseBody;
  final String? reasonPhrase;

  ApiResponse({required this.statusCode, required this.responseBody, this.reasonPhrase});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}