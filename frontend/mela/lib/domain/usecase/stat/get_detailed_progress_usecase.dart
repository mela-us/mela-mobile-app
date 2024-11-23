import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/stat/detailed_progress_list.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';

class GetDetailedProgressListUseCase extends UseCase<DetailedProgressList, void>{
  final StatRepository _statRepository;

  GetDetailedProgressListUseCase(this._statRepository);

  @override
  Future<DetailedProgressList> call({required params}) {
    return _statRepository.getDetailedProgressList();
  }
}