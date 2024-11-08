const _kDefaultReceiveTimeout = 10000;
const _kDefaultConnectionTimeout = 10000;

//Cấu hình cho dio_client.dart ở dưới
class DioConfigs {
  final String baseUrl;
  final int receiveTimeout;
  final int connectionTimeout;

  const DioConfigs({
    required this.baseUrl,
    this.receiveTimeout = _kDefaultReceiveTimeout,
    this.connectionTimeout = _kDefaultConnectionTimeout,
  });
}
