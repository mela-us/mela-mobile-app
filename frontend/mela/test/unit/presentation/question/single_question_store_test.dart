import 'package:flutter_test/flutter_test.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mockito/annotations.dart';

import 'single_question_store_test.mocks.dart';

// Generate mock classes
@GenerateMocks([SingleQuestionStore])
void main() {
  late SingleQuestionStore singleQuestionStore;

  setUp(() {
    singleQuestionStore = SingleQuestionStore();
  });

  group('SingleQuestionStore - Success Cases', () {
    test('Should generate answer list with given length', () {
      singleQuestionStore.generateAnswerList(3);
      expect(singleQuestionStore.userAnswers.length, equals(3));
      expect(singleQuestionStore.userAnswers, equals(["", "", ""]));
    });

    test('Should change the question index', () {
      singleQuestionStore.changeQuestion(2);
      expect(singleQuestionStore.currentIndex, equals(2));
    });

    test('Should set answer at given index', () {
      singleQuestionStore.generateAnswerList(3);
      singleQuestionStore.setAnswer(1, "B");

      expect(singleQuestionStore.userAnswers[1], equals("B"));
    });

    test('Should update quiz answer value', () {
      singleQuestionStore.setQuizAnswerValue("D");
      expect(singleQuestionStore.currentQuizAnswer, equals("D"));
    });

    test('Should retrieve the correct current answer', () {
      singleQuestionStore.generateAnswerList(3);
      singleQuestionStore.setAnswer(0, "A");
      singleQuestionStore.changeQuestion(0);

      expect(singleQuestionStore.currentAnswer, equals("A"));
    });
  });
}
