import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';

import '../../../../domain/params/history/exercise_progress_params.dart';
import '../../../../domain/params/history/section_progress_params.dart';

class UpdateProgressApi{
  final DioClient _dioClient;

  UpdateProgressApi(this._dioClient);

  Future<int> updateExerciseProgress(ExerciseProgressParams param) async{
    try {
      final response = await _dioClient.post(
        EndpointsConst.updateExerciseProgress,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: param.toJson(),
      );
      return 200;
    }
    catch (e){
      print(e);
      return 401;
    }
  }

  Future<int> updateSectionProgress(SectionProgressParams param) async{
    try {
      final response = await _dioClient.post(
        EndpointsConst.updateSectionProgress,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: param.toJson(),
      );
      return 200;
    }
    catch (e){
      print(e);
      return 401;
    }
  }
}