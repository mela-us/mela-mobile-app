package com.hcmus.mela.utils;

import org.springframework.stereotype.Service;

import java.text.Normalizer;
import java.util.regex.Pattern;

public class UnicodeUtils {
    public static String removeAccent(String s) {
        if (s == null) return null;
        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(temp).replaceAll("");
    }
}
