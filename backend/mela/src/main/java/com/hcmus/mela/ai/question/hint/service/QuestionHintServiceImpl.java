package com.hcmus.mela.ai.question.hint.service;

import com.hcmus.mela.ai.question.hint.model.QuestionHint;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class QuestionHintServiceImpl implements QuestionHintService {

    private final QuestionHint questionHint;

    @Override
    public String generateTermTask(String level) {
        String taskTemplate = questionHint.getTerm().get("task").toString();
        return taskTemplate.replace("{level}", level);
    }

    @Override
    public String generateTermData(String question, String answer) {
        String dataTemplate = questionHint.getTerm().get("data").toString();
        return dataTemplate.replace("{question}", question)
                .replace("{answer}", answer);
    }

    @Override
    public String generateTermBackground(String level) {
        String backgroundTemplate = questionHint.getTerm().get("background").toString();
        return backgroundTemplate.replace("{level}", level);
    }

    @Override
    public String generateTermRequirement(String level) {
        String requirementTemplate = questionHint.getTerm().get("requirement").toString();
        return requirementTemplate.replace("{level}", level);
    }

    @Override
    public String generateTerm(String level, String question, String answer) {
        String term = generateTermTask(level) + "\n"
                + generateTermData(question, answer) + "\n"
                + generateTermBackground(level) + "\n"
                + generateTermRequirement(level);

        return term;
    }

    @Override
    public String generateGuideTask(String level) {
        String taskTemplate = questionHint.getGuide().get("task").toString();
        return taskTemplate.replace("{level}", level);
    }

    @Override
    public String generateGuideData(String question, String answer) {
        String dataTemplate = questionHint.getGuide().get("data").toString();
        return dataTemplate.replace("{question}", question)
                .replace("{answer}", answer);
    }

    @Override
    public String generateGuideBackground(String level) {
        String backgroundTemplate = questionHint.getGuide().get("background").toString();
        return backgroundTemplate.replace("{level}", level);
    }

    @Override
    public String generateGuideRequirement(String level) {
        String requirementTemplate = questionHint.getGuide().get("requirement").toString();
        return requirementTemplate.replace("{level}", level);
    }

    @Override
    public String generateGuide(String level, String answer, String question) {
        String guide = "";

        guide += generateGuideTask(level);
        guide += generateGuideData(question, answer);
        guide += generateGuideBackground(level);
        guide += generateGuideRequirement(level);

        return guide;
    }
}
