import 'package:dio/dio.dart';
import 'package:drug_alert_frontend/core/constants/app_endpoints.dart';
import 'package:drug_alert_frontend/core/dialogs/dialog.dart';
import 'package:drug_alert_frontend/core/route/app_routes.dart';
import 'package:drug_alert_frontend/core/services/api_handler/api_client_config.dart';
import 'package:drug_alert_frontend/core/services/api_handler/api_handler_models.dart';
import 'package:drug_alert_frontend/features/home/presentation/pages/home.dart';
import 'package:drug_alert_frontend/features/home/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drugProvider = StateNotifierProvider<DrugNotifier, DrugRepo>((ref) {
  return DrugNotifier(ref, DrugRepo());
});

class DrugNotifier extends StateNotifier<DrugRepo> {
  final Ref ref;
  final DrugRepo repo;
  DrugNotifier(this.ref, this.repo) : super(DrugRepo());

  Future<void> createDrug(
    BuildContext context, {
    required String drugName,
    required String expiryDate,
  }) async {
    Dialogs.showLoadingDialog(context);
    final res = await repo.createDrug(
      drugName: drugName,
      expiryDate: expiryDate,
    );
    if (!mounted) return;
    pop(context);
    if (res.valid) {
      ref.refresh(userProvider);
      pushToAndClearStack(
        context,
        const HomeScreen(),
      );
    } else {
      Dialogs.showErrorSnackbar(context, message: res.error!.message!);
    }
  }

  Future<void> deleteDrug(
    BuildContext context, {
    required String id,
  }) async {
    Dialogs.showLoadingDialog(context);
    final res = await repo.deleteDrug(
      id: id,
    );
    if (!mounted) return;
    pop(context);
    if (res.valid) {
      ref.refresh(userProvider);
    } else {
      Dialogs.showErrorSnackbar(context, message: res.error!.message!);
    }
  }
}

class DrugRepo {
  final BackendService _apiService = BackendService(Dio());

  Future<ResponseModel> createDrug({
    required String drugName,
    required String expiryDate,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/create_drug',
        data: {
          "drug_name": drugName,
          "expiry_date": expiryDate,
        },
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

  Future<ResponseModel> deleteDrug({
    required String id,
  }) async {
    Response response = await _apiService.runCall(
      _apiService.dio.post(
        '${AppEndpoints.baseUrl}/delete_drug',
        data: {
          "_id": id,
        },
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
}
