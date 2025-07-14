import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

typedef ConnectivityResultCallback = void Function();

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();

  factory ConnectivityService() => _instance;

  ConnectivityService._internal() {
    _initConnectivity();
  }

  /// [Connectivity] instance
  final Connectivity _connectivity = Connectivity();

  /// [ConnectivityResult] callbacks
  final List<ConnectivityResultCallback> _callbacks = [];

  /// [StreamSubscription] for connectivity changes
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// [ConnectivityResult] current result
  void _initConnectivity() {
    if (_subscription != null) {
      return;
    }
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      final hasConnection = event.contains(ConnectivityResult.mobile) ||
          event.contains(ConnectivityResult.wifi) ||
          event.contains(ConnectivityResult.ethernet);
      if (hasConnection) {
        // print("Sa =====> Có internet khi thay đổi kết nối");
        _handleOnlineWhenHasInternetAgain();
      } else {
        // print("Sa =====> Không có internet khi thay đổi kết nối");
      }
    });
  }

  /// add callback to listen for connectivity changes
  void addCallBackListen(ConnectivityResultCallback callback) {
    // print(
    //     "Sa =====> CallBack Funtion Length Luc trc khi add vao ${_callbacks.length}");
    if (!_callbacks.contains(callback)) {
      _callbacks.add(callback);
    }
    // print(
    //     "Sa =====> CallBack Funtion Length Luc sau khi add vao ${_callbacks.length}");

    //Nếu lần đầu bất kì cái nào vô mà chưa gọi
    if (_subscription == null) {
      _initConnectivity();
    }
  }

  /// Stop listening to connectivity changes
  void removeCallBackListen(ConnectivityResultCallback? callback) {
    // print(
    //     "Sa =====> CallBack Funtion Length Luc trc khi off ${_callbacks.length}");
    if (callback != null) {
      _callbacks.remove(callback);
    }
    if (_callbacks.isEmpty) {
      _subscription?.cancel();
      _subscription = null;
    }
    // print(
    //     "Sa =====> CallBack Funtion Length Luc sau khi off ${_callbacks.length}");
  }

  /// Dispose of the service
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _callbacks.clear();
  }

  void _handleOnlineWhenHasInternetAgain() {
    for (var callback in List<ConnectivityResultCallback>.from(_callbacks)) {
      try {
        callback();
      } catch (e) {
        // Log or handle individual callback errors if needed
      }
    }
  }
}
