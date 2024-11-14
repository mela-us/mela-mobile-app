package com.hcmus.mela.utils;

import java.util.Locale;

public final class ProjectConstants {

    public static final String DEFAULT_ENCODING = "UTF-8";

    public static final String CONTENT_DATABASE_NAME = "mela_content";

    public static final Locale US_LOCALE = new Locale.Builder().setLanguage("en").setRegion("US").build();

    private ProjectConstants() {

        throw new UnsupportedOperationException();
    }

}
