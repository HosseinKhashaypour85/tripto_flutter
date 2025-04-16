import 'package:dio/dio.dart';
import 'package:tripto_flutter/features/notifications_features/model/notifications_model.dart';
import 'package:tripto_flutter/features/notifications_features/services/notifications_api_services.dart';

class NotificationsApiRepository {
  final NotificationsApiServices _apiServices = NotificationsApiServices();
  Future<NotificationsModel>callNotificationsApi()async{
    final Response response = await _apiServices.callNotificationsApi();
    NotificationsModel notificationsModel = NotificationsModel.fromJson(response.data);
    return notificationsModel;
  }
}