import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/stat/progress_list.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';

class GetProgressListUseCase extends UseCase<ProgressList, void>{
  final StatRepository _statRepository;

  GetProgressListUseCase(this._statRepository);

  @override
  Future<ProgressList> call({required params}) {
    return _statRepository.getProgressList();
  }
}