
import 'package:mela/domain/entity/level/level_list.dart';

abstract class LevelRepository {
  Future<LevelList> getLevels();
}
