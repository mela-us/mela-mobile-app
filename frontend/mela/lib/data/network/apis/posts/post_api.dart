import 'dart:async';

//Data:-------------------------------------------------------------------------
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/data/network/rest_client.dart';

//Domain:-----------------------------------------------------------------------
import 'package:mela/domain/entity/post/post_list.dart';

//Other:------------------------------------------------------------------------
import '../../constants/endpoints_const.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<PostList> getPosts() async {
    try {
      //print("------------->PostApi: getPosts");
      final res = await _dioClient.get(EndpointsConst.getPosts);
      
      return PostList.fromJson(res);
    } catch (e) {
      print("-------------->PostApi: getPosts: Error");
      print(e.runtimeType);
      //print(_restClient.toString());
      rethrow;
    }

  }

  /// sample api call with default rest client
//   Future<PostList> getPosts() async {
//     try {
//       final res = await _restClient.get(Endpoints.getPosts);
//       return PostList.fromJson(res.data);
//     } catch (e) {
//       print(e.toString());
//       throw e;
//     }
//   }
}
