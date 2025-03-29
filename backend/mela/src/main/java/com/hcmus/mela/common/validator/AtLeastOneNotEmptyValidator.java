package com.hcmus.mela.common.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import java.lang.reflect.Field;

public class AtLeastOneNotEmptyValidator implements ConstraintValidator<AtLeastOneNotEmpty, Object> {
    private String[] fields;

    @Override
    public void initialize(AtLeastOneNotEmpty constraintAnnotation) {
        this.fields = constraintAnnotation.fields();
    }

    @Override
    public boolean isValid(Object object, ConstraintValidatorContext context) {
        if (object == null) {
            return false;
        }

        try {
            for (String fieldName : fields) {
                Field field = object.getClass().getDeclaredField(fieldName);
                field.setAccessible(true);
                Object value = field.get(object);

                if (value instanceof String str && str.trim().isEmpty()) {
                    return false;
                }

                if (value != null) {
                    return true;
                }
            }
        } catch (NoSuchFieldException | IllegalAccessException e) {
            return false;
        }

        context.disableDefaultConstraintViolation();
        context.buildConstraintViolationWithTemplate("At least one of " + String.join(", ", fields) + " must not be empty")
                .addConstraintViolation();

        return false;
    }
}
