import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mockito/mockito.dart';
import 'package:mela/presentation/question/question.dart';
import 'package:provider/provider.dart';

// Mock các Store cần thiết
class MockTimerStore extends Mock implements TimerStore {}
class MockQuestionStore extends Mock implements QuestionStore {}
class MockSingleQuestionStore extends Mock implements SingleQuestionStore {}

void main() {
  late MockTimerStore timerStore;
  late MockQuestionStore questionStore;
  late MockSingleQuestionStore singleQuestionStore;

  setUp(() {
    timerStore = MockTimerStore();
    questionStore = MockQuestionStore();
    singleQuestionStore = MockSingleQuestionStore();
  });

  Widget createTestWidget() {
    return MultiProvider(
      providers: [
        Provider<TimerStore>.value(value: timerStore),
        Provider<QuestionStore>.value(value: questionStore),
        Provider<SingleQuestionStore>.value(value: singleQuestionStore),
      ],
      child: MaterialApp(
        home: QuestionScreen(),
      ),
    );
  }

  testWidgets('Hiển thị màn hình câu hỏi', (WidgetTester tester) async {
    when(questionStore.loading).thenReturn(false);
    when(singleQuestionStore.currentIndex).thenReturn(0);

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    expect(find.byType(QuestionScreen), findsOneWidget);
  });

  testWidgets('Nhấn nút tiếp tục', (WidgetTester tester) async {
    when(questionStore.loading).thenReturn(false);
    when(singleQuestionStore.currentIndex).thenReturn(0);
    when(singleQuestionStore.changeQuestion(1)).thenReturn(null);

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    final continueButton = find.text('Tiếp tục');
    expect(continueButton, findsOneWidget);

    await tester.tap(continueButton);
    await tester.pump();

    verify(singleQuestionStore.changeQuestion(1)).called(1);
  });
}