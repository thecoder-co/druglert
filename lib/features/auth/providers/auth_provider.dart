import 'package:dio/dio.dart';
import 'package:drug_alert_frontend/core/constants/app_endpoints.dart';
import 'package:drug_alert_frontend/core/dialogs/dialog.dart';
import 'package:drug_alert_frontend/core/route/app_routes.dart';
import 'package:drug_alert_frontend/core/services/api_handler/api_client_config.dart';
import 'package:drug_alert_frontend/core/services/api_handler/api_handler_models.dart';
import 'package:drug_alert_frontend/core/services/local_data.dart';
import 'package:drug_alert_frontend/features/auth/models/login_model.dart';
import 'package:drug_alert_frontend/features/auth/presentation/pages/login_screen.dart';
import 'package:drug_alert_frontend/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthRepo>((ref) {
  return AuthNotifier(ref, AuthRepo());
});

class AuthNotifier extends StateNotifier<AuthRepo> {
  final Ref ref;
  final AuthRepo repo;
  AuthNotifier(this.ref, this.repo) : super(AuthRepo());

  Future<void> registerUser(BuildContext context) async {
    Dialogs.showLoadingDialog(context);
    final res = await repo.registerWithEmailAndPassword(
      email: state.email!,
      password: state.password!,
    );
    if (!mounted) return;
    pop(context);
    if (res.valid) {
      pushTo(
        context,
        const LoginScreen(),
      );
    } else {
      Dialogs.showErrorSnackbar(context, message: res.error!.message!);
    }
  }

  Future<void> loginUser(BuildContext context) async {
    Dialogs.showLoadingDialog(context);
    final res = await repo.loginWithEmailAndPassword(
      email: state.email!,
      password: state.password!,
    );
    if (!mounted) return;
    pop(context);
    if (res.valid) {
      LocalData.getInstance.setToken(res.data!.accessToken);
      pushToAndClearStack(context, const HomeScreen());
    } else {
      Dialogs.showErrorSnackbar(context, message: res.error!.message!);
    }
  }
}

class AuthRepo {
  final BackendService _apiService = BackendService(Dio());

  String? email;
  String? password;

  Future<ResponseModel> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/register',
        data: {"email": email, "password": password},
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data),
      statusCode: statusCode,
      message: response.data['message'],
    );
  }

  Future<ResponseModel<LoginModel>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/login',
        data: {"email": email, "password": password},
      ),
    );

    final int statusCode = response.statusCode ?? 000;

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel<LoginModel>(
        valid: true,
        statusCode: statusCode,
        message: response.statusMessage,
        data: LoginModel.fromJson(response.data),
      );
    }

    return ResponseModel(
      error: ErrorModel.fromJson(response.data),
      statusCode: statusCode,
      message: response.data['message'],
    );
  }
}
