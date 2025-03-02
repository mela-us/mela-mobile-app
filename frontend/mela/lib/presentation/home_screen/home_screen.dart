import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/home_screen/widgets/level_item.dart';
import 'package:mobx/mobx.dart';

import '../../di/service_locator.dart';
import '../../themes/default/colors_standards.dart';
import '../../utils/routes/routes.dart';
import '../topic_lecture_in_level_screen/widgets/lecture_item.dart';
import 'widgets/cover_image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  final LevelStore _levelStore = getIt<LevelStore>();
  late final ReactionDisposer _unAuthorizedReactionDisposer;
  @override
  void initState() {
    super.initState();
    //routeObserver.subscribe(this, ModalRoute.of(context));

    //for only refresh token expired
    _unAuthorizedReactionDisposer = reaction(
      (_) => _levelStore.isUnAuthorized,
      (value) {
        if (value) {
          _levelStore.isUnAuthorized = false;
          _levelStore.resetErrorString();
          //Remove all routes in stack
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginOrSignupScreen, (route) => false);
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies In HomeScreen");
    //print("========TopicError: ${_topicStore.errorString}");
    // check to see if already called api
    if (!_levelStore.loading) {
      _levelStore.getLevels();
      _levelStore.getTopics();
      _levelStore.getAreLearningLectures();
    }
  }

  @override
  void dispose() {
    //routeObserver.unsubscribe(this);
    _unAuthorizedReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen1: ${_topicStore.errorString}");
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text("MELA",
              style: Theme.of(context)
                  .textTheme
                  .heading
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        actions: [
          Observer(builder: (context) {
            if (_levelStore.errorString.isNotEmpty ||
                _levelStore.lecturesAreLearningList == null ||
                _levelStore.topicList == null ||
                _levelStore.levelList == null) {
              return const SizedBox.shrink();
            }
            //Icon search
            return IconButton(
              onPressed: () {
                //eg: incourse no wifi, enter search, turnon wifi, back to app
                _levelStore.resetErrorString();
                Navigator.of(context).pushNamed(Routes.searchScreen);
              },
              icon: const Icon(Icons.search),
              color: Theme.of(context).colorScheme.onPrimary,
            );
          })
        ],
      ),
      body: Observer(
        builder: (context) {
          //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen2: ${_topicStore.errorString}");
          if (_levelStore.loading) {
            return AbsorbPointer(
              absorbing: true,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  ),
                  const RotatingImageIndicator(),
                ],
              ),
            );
          }
          //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen 3: ${_topicStore.errorString}");
          if (_levelStore.errorString.isNotEmpty ||
              _levelStore.lecturesAreLearningList == null ||
               _levelStore.topicList == null ||
              _levelStore.levelList == null) {
            return Center(
              child: Text(_levelStore.errorString,
                  style: const TextStyle(color: Colors.red)),
            );
          }
          //print("build In CoursesScreen+++++++++++++++++++++++++++++++");
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Cover Image Introduction
                    const CoverImageWidget(),
                    const SizedBox(height: 15),
                    //Levels Grid
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: 1,
                        mainAxisExtent: 100, // set the height of each item
                      ),
                      itemCount: _levelStore.levelList!.levelList.length,
                      itemBuilder: (context, index) {
                        return LevelItem(
                          level: _levelStore.levelList!.levelList[index],
                        );
                      },
                    ),

                    const SizedBox(height: 15),
                    //Text "lectures đang học"
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/fire.png',
                            width: 20,
                            height: 28,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Bài giảng đang học",
                            style: Theme.of(context)
                                .textTheme
                                .subTitle
                                .copyWith(
                                    color:
                                        ColorsStandards.textColorInBackground2),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    //Lectures is learning

                    Column(
                      children: _levelStore.lecturesAreLearningList!.lectures
                          .map((lecture) {
                        return LectureItem(lecture: lecture);
                      }).toList(),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
