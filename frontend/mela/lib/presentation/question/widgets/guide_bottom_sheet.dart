import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/data/network/apis/questions/hint_api.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/question/guide_controller.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';

class GuideBottomSheet extends StatefulWidget {
  final screenHeight;
  const GuideBottomSheet({super.key, this.screenHeight});

  @override
  State<GuideBottomSheet> createState() => _GuideBottomSheetState();
}

class _GuideBottomSheetState extends State<GuideBottomSheet> {
  final SingleQuestionStore _singleQuestionStore = getIt<SingleQuestionStore>();
  final QuestionStore _questionStore = getIt<QuestionStore>();
  late double _screenHeight;
  final List<GuideController> guides = [
    GuideController(
        title: "Các khái niệm và thuật ngữ trong câu hỏi này?",
        guide: "Số người tham gia: Là số đối tượng trong sự kiện, ở đây là 12, tương ứng số phần tử của một tập hợp. \n\n"
            "Toán tổ hợp: Ngành toán học nghiên cứu cách đếm và sắp xếp. Bài toán yêu cầu tìm số cách chọn 2 người từ 12 mà không xét thứ tự."
    ),
    GuideController(
        guide: "Hãy tưởng tượng trong buổi tiệc, mỗi người sẽ lần lượt bắt tay với tất cả những người khác. \n\n"
            "Nếu ta đếm từng cái bắt tay theo cách này, một cái bắt tay giữa hai người sẽ bị đếm hai lần (ví dụ, nếu A bắt tay với B thì cũng tính B bắt tay với A).",
        title: "Phương pháp chính áp dụng cho câu hỏi này?"
    ),
    GuideController(guide: "1. Trong một nhóm có 10 người, mỗi người đều bắt tay với mỗi người khác một lần. Hỏi có bao nhiêu cái bắt tay đã diễn ra? \n\n"
        "2. Một giải đấu cờ vua có 8 người tham gia, mỗi người thi đấu một lần với mỗi người khác. Hỏi tổng số trận đấu diễn ra là bao nhiêu?",
        title: "Các câu hỏi tương tự với câu hỏi này?"
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _screenHeight = widget.screenHeight;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      padding: const EdgeInsets.all(16),
      height: _screenHeight/2 + 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 27,
              ),

              Text(
                "Các gợi ý",
                style: Theme.of(context).textTheme.heading
                    .copyWith(color: Theme.of(context).colorScheme.textInBg1),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 27,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded( child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSuggestionItem(guides[0]),
                _buildSuggestionItem(guides[1]),
              ],
            ),
          )
          )
        ],
      ),
    );
  }
  Widget _buildSuggestionItem(GuideController g) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 24,
                color: Theme
                    .of(context)
                    .colorScheme
                    .buttonYesBgOrText,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  g.title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subTitle
                      .copyWith(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .buttonYesBgOrText),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          g.isCalled ?
          _buildGuideView(g.guide) :

          Center(
            child: SizedBox(
              height: 44,
              width: 171,
              child: ElevatedButton(
                onPressed: () async {
                  // Call the API to generate the guide
                  HintApi hintApi = HintApi(getIt<DioClient>());
                  String id = _questionStore.questionList!.questions![_singleQuestionStore.currentIndex].questionId!;


                  setState(() {
                    g.changeState();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  side: BorderSide(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .buttonYesBgOrText),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          const LinearGradient(
                            colors: [
                              Color(0xFF31BCFF),
                              Color(0xFF9676FF),
                              Color(0xFFBE64FE),
                              Color(0xFFE157CB),
                              Color(0xFFEF5794),
                              Color(0xFFFD683F),
                              Color(0xFFFE7C2B),
                              Color(0xFFFFA10B),
                            ],
                          ).createShader(bounds),
                      blendMode: BlendMode.srcIn, // Áp dụng gradient lên icon
                      child: const Icon(Icons.auto_awesome, size: 20),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Khởi tạo gợi ý",
                      style: Theme
                          .of(context)
                          .textTheme
                          .normal
                          .copyWith(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .buttonYesBgOrText
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGuideView(String guidance) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            guidance,
            style: Theme
                .of(context)
                .textTheme
                .normal
                .copyWith(
              color: Theme
                  .of(context)
                  .colorScheme
                  .inputTitleText,
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.comment_outlined, size: 16)
            ),
            const SizedBox(width: 7),
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.thumb_up_alt_outlined, size: 16)
            ),
            const SizedBox(width: 7),
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.thumb_down_alt_outlined, size: 16)
            ),
          ],
        )
      ],
    );
  }

}
