import 'package:mela/data/network/apis/level/level_api.dart';
import 'package:mela/domain/entity/level/level_list.dart';
import 'package:mela/domain/repository/level/level_repository.dart';

class LevelRepositoryImpl extends LevelRepository{
  LevelApi _levelApi;
  LevelRepositoryImpl(this._levelApi);
  @override
  Future<LevelList> getLevels() {
    return _levelApi.getLevelList();
  }

}