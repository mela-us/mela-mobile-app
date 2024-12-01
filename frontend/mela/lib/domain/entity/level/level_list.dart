import 'package:mela/domain/entity/level/level.dart';

class LevelList {
  List<Level> levelList;
  LevelList({required this.levelList});
  factory LevelList.fromJson(List<dynamic> json) {
    List<Level> list = <Level>[];
    list = json.map((level) => Level.fromJson(level)).toList();
    return LevelList(
      levelList: list,
    );
  }
  
}