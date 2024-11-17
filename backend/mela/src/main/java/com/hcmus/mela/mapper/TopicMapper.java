package com.hcmus.mela.mapper;

import com.hcmus.mela.dto.service.LevelDto;
import com.hcmus.mela.dto.service.TopicDto;
import com.hcmus.mela.model.mongo.Level;
import com.hcmus.mela.model.mongo.Topic;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface TopicMapper {
    TopicMapper INSTANCE = Mappers.getMapper(TopicMapper.class);

    TopicDto topicToTopicDto(Topic topic);
}
