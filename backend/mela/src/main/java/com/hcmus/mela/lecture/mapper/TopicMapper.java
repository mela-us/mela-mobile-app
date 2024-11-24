package com.hcmus.mela.lecture.mapper;

import com.hcmus.mela.lecture.dto.TopicDto;
import com.hcmus.mela.lecture.model.Topic;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface TopicMapper {
    TopicMapper INSTANCE = Mappers.getMapper(TopicMapper.class);

    TopicDto topicToTopicDto(Topic topic);
}
