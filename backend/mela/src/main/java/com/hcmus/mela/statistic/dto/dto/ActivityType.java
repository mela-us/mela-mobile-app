package com.hcmus.mela.statistic.dto.dto;

public enum ActivityType {
    EXERCISE, SECTION, TEST, ALL;

    static public ActivityType fromValue(String type) {
        type = type.toUpperCase();
        return switch (type) {
            case "EXERCISE" -> ActivityType.EXERCISE;
            case "SECTION" -> ActivityType.SECTION;
            case "TEST" -> ActivityType.TEST;
            default -> ActivityType.ALL;
        };
    }
}
