import 'package:dio/dio.dart';
import 'package:drug_alert_frontend/core/constants/app_endpoints.dart';
import 'package:drug_alert_frontend/core/route/app_routes.dart';
import 'package:drug_alert_frontend/core/services/api_handler/api_client_config.dart';
import 'package:drug_alert_frontend/core/services/api_handler/api_handler_models.dart';
import 'package:drug_alert_frontend/core/services/local_data.dart';
import 'package:drug_alert_frontend/features/auth/presentation/pages/login_screen.dart';
import 'package:drug_alert_frontend/features/home/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = FutureProvider<UserModel>((ref) async {
  final res = await getProfile();
  return res.data!;
});

void checkTokenValid(BuildContext context) async {
  final res = await getProfile();
  if (res.statusCode != 200) {
    LocalData.getInstance.setToken(null);
    pushToAndClearStack(context, const LoginScreen());
  }
}

final BackendService _apiService = BackendService(Dio());

Future<ResponseModel<UserModel>> getProfile() async {
  Response response = await _apiService.runCall(
    _apiService.dio.get(
      '${AppEndpoints.baseUrl}/profile',
    ),
  );

  final int statusCode = response.statusCode ?? 000;

  if (statusCode >= 200 && statusCode <= 300) {
    return ResponseModel<UserModel>(
      valid: true,
      statusCode: statusCode,
      message: response.statusMessage,
      data: UserModel.fromJson(response.data),
    );
  }

  return ResponseModel(
    error: ErrorModel.fromJson(response.data),
    statusCode: statusCode,
    message: response.data['message'],
  );
}
