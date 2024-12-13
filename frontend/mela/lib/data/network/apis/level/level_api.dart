import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/level/level.dart';
import 'package:mela/domain/entity/level/level_list.dart';

class LevelApi {
  final DioClient _dioClient;
  LevelApi(this._dioClient);
  Future<LevelList> getLevelList() async {
    print("================================ở getLevelList API");
    // final responseData = await _dioClient.get(
    //   EndpointsConst.getLevels,
    // );
    //LevelList.fromJson(responseData['data']);
    await Future.delayed(Duration(seconds: 1));
    LevelList demo = LevelList(
      levelList: [
        Level(
          levelId: "1",
          levelName: "Grade 1",
          levelImagePath: "assets/images/grades/grade1.png",
        ),
        Level(
          levelId: "2",
          levelName: "Grade 2",
          levelImagePath: "assets/images/grades/grade2.png",
        ),
        Level(
          levelId: "3",
          levelName: "Grade 3",
          levelImagePath: "assets/images/grades/grade3.png",
        ),
        Level(
          levelId: "4",
          levelName: "Grade 4",
          levelImagePath: "assets/images/grades/grade4.png",
        ),
        Level(
          levelId: "5",
          levelName: "Grade 5",
          levelImagePath: "assets/images/grades/grade5.png",
        ),
        Level(
          levelId: "6",
          levelName: "Grade 6",
          levelImagePath: "assets/images/grades/grade6.png",
        ),
        Level(
          levelId: "7",
          levelName: "Grade 7",
          levelImagePath: "assets/images/grades/grade7.png",
        ),
        Level(
          levelId: "8",
          levelName: "Grade 8",
          levelImagePath: "assets/images/grades/grade8.png",
        ),
        Level(
          levelId: "9",
          levelName: "Grade 9",
          levelImagePath: "assets/images/grades/grade9.png",
        ),
      ],
    );
    return demo;
  }
}
