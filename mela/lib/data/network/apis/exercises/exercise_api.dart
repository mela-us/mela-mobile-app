import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/exercise/exercise_list.dart';

class ExerciseApi {
  DioClient _dioClient;
  ExerciseApi(this._dioClient);

  Future<ExerciseList> getExercises(String lectureId) async {

    print("================================ ở getExercises API");
    final url = EndpointsConst.getExercises.replaceAll(':lectureId', lectureId);
    final responseData = await _dioClient.get(url);
    return ExerciseList.fromJson(responseData['exercises']);
    // print(
    //     "================================********==================");
    // print("a=: ${a}");n
  }
}
