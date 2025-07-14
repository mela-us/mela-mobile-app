import 'package:flutter/material.dart';
import 'package:mela/core/services/connectivity_service.dart';

mixin ConnectivityManager<T extends StatefulWidget> on State<T> {
  final ConnectivityService _connectivityService = ConnectivityService();

  void addCallBack() {
    _connectivityService.addCallBackListen(handleChangeToOnline);
  }

  void removeCallBack() {
    _connectivityService.removeCallBackListen(handleChangeToOnline);
  }

  void handleChangeToOnline();
}
