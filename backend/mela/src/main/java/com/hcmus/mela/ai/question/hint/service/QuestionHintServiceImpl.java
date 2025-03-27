package com.hcmus.mela.ai.question.hint.service;

import com.hcmus.mela.ai.question.hint.model.QuestionHint;
import com.hcmus.mela.exercise.model.Exercise;
import com.hcmus.mela.exercise.model.Option;
import com.hcmus.mela.exercise.model.Question;
import com.hcmus.mela.exercise.service.ExerciseService;
import com.hcmus.mela.exercise.service.QuestionService;
import com.hcmus.mela.lecture.model.Lecture;
import com.hcmus.mela.lecture.model.Level;
import com.hcmus.mela.lecture.service.LevelService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionHintServiceImpl implements QuestionHintService {

    private final QuestionHint questionHint;

    private final QuestionService questionService;

    private final ExerciseService exerciseService;

    private final LectureDetailService lectureDetailService;

    private final LevelService levelService;

    public List<String> generateKeys(UUID questionId) {
        Question question = questionService.findByQuestionId(questionId);

        Exercise exercise = exerciseService.findByQuestionId(questionId);

        Lecture lecture = lectureDetailService.getLectureById(exercise.getLectureId());

        Level level = levelService.findLevelByLevelId(lecture.getLevelId());

        List<String> keys = new ArrayList<>();

        keys.add(level.getName());

        keys.add(question.getContent());

        String answer = "Lời giải: " + question.getGuide();

        if (question.getBlankAnswer() != null) {
            answer += ("\nĐáp án: " + question.getBlankAnswer());
        } else {
            answer += "\nĐáp án: ";

            for (Option option : question.getOptions()) {
                if (option.getIsCorrect()) {
                    answer += option.getContent();
                    break;
                }
            }
        }

        keys.add(answer);

        return keys;
    }

    public List<String> generateTemplate(Map<String, String> instruction,
                                         Map<String, String> userMessages,
                                         List<String> keys) {
        List<String> template = new ArrayList<>();

        String task = instruction.get("task").replace("{level}", keys.get(0))
                .replace("{question}", keys.get(1))
                .replace("{answer}", keys.get(2));

        String background = instruction.get("background").replace("{level}", keys.get(0))
                .replace("{question}", keys.get(1))
                .replace("{answer}", keys.get(2));

        String requirement = instruction.get("requirement").replace("{level}", keys.get(0))
                .replace("{question}", keys.get(1))
                .replace("{answer}", keys.get(2));

        template.add(task + "\n" + background + "\n" + requirement);

        template.add(userMessages.get("data")
                .replace("{level}", keys.get(0))
                .replace("{question}", keys.get(1))
                .replace("{answer}", keys.get(2)));

        return template;
    }

    @Override
    public List<String> generateTerm(UUID questionId) {

        List<String> keys = generateKeys(questionId);

        Map<String, String> instruction = questionHint.getTerm().get("instruction");

        Map<String, String> userMessages = questionHint.getTerm().get("userMessages");

        return generateTemplate(instruction, userMessages, keys);
    }

    @Override
    public List<String> generateGuide(UUID questionId) {

        List<String> keys = generateKeys(questionId);

        Map<String, String> instruction = questionHint.getGuide().get("instruction");

        Map<String, String> userMessages = questionHint.getGuide().get("userMessages");

        return generateTemplate(instruction, userMessages, keys);
    }
}
