import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/presigned_image/presigned_image.dart';

class PresignedImageApi {
  final DioClient _dioClient;
  PresignedImageApi(this._dioClient);
  Future<PresignedImage> getPresignedImage() async {
    print("================================ ở presigned image API");
    final responseData = await _dioClient.get(
      EndpointsConst.getPresignUrl,
    );
    print("-----> presigned image API: $responseData");
    return PresignedImage.fromJson(responseData);
  }
}
