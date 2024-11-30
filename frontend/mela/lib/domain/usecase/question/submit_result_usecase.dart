import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/data/network/apis/questions/save_result_api.dart';

import '../../params/question/submit_result_params.dart';

class SubmitResultUseCase extends UseCase<int, SubmitResultParams>{
  final SaveResultApi _saveApi;

  SubmitResultUseCase(this._saveApi);
  @override
  Future<int> call({required SubmitResultParams params}) async {
    int resultCode = await _saveApi.saveResult(params);
    return resultCode;
  }
}