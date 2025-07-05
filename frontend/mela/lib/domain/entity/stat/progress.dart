import 'package:mela/domain/entity/stat/score_record.dart';

class Progress {
  String type;
  String latestDate;
  String? topicName;
  String? lectureName;
  ProgressExercise? exercise;
  ProgressSection? section;
  ProgressExam? exam;

  bool get isGain {
    return exercise?.isGain ?? exam?.isGain ?? false;
  }

  bool get isDrop {
    return exercise?.isDrop ?? exam?.isDrop ?? false;
  }

  Progress({
    required this.type,
    required this.latestDate,
    this.topicName,
    this.lectureName,
    this.exercise,
    this.section,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      type: json['type'],
      latestDate: json['latestDate'],
      topicName: json['topicName'],
      lectureName: json['lectureName'],
      exercise: json['exercise'] != null ? ProgressExercise.fromJson(json['exercise']) : null,
      section: json['section'] != null ? ProgressSection.fromJson(json['section']) : null,
    );
  }
}

class ProgressExercise {
  String exerciseName;
  double latestScore;
  List<ScoreRecord> scoreRecords;

  bool get isGain {
    return scoreRecords.length > 1 && scoreRecords[0].score > scoreRecords[1].score;
  }

  bool get isDrop {
    return scoreRecords.length > 1 && scoreRecords[0].score < scoreRecords[1].score;
  }

  ProgressExercise({
    required this.exerciseName,
    required this.latestScore,
    required this.scoreRecords,
  });

  factory ProgressExercise.fromJson(Map<String, dynamic> json) {
    var scoreRecordsFromJson = json['scoreRecords'] as List;
    List<ScoreRecord> scoreRecordsList = scoreRecordsFromJson.map((i) => ScoreRecord.fromJson(i)).toList();

    return ProgressExercise(
      exerciseName: json['exerciseName'],
      latestScore: json['latestScore'],
      scoreRecords: scoreRecordsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': exerciseName,
      'latestScore': latestScore,
      'scoreRecords': scoreRecords.map((e) => e.toJson()).toList(),
    };
  }
}

class ProgressSection {
  String sectionName;
  String date;

  ProgressSection({
    required this.sectionName,
    required this.date,
  });

  factory ProgressSection.fromJson(Map<String, dynamic> json) {
    return ProgressSection(
      sectionName: json['sectionName'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sectionName': sectionName,
      'date': date,
    };
  }
}

class ProgressExam {
  double latestScore;
  List<ScoreRecord> scoreRecords;

  bool get isGain {
    return scoreRecords.length > 1 && scoreRecords[0].score > scoreRecords[1].score;
  }

  bool get isDrop {
    return scoreRecords.length > 1 && scoreRecords[0].score < scoreRecords[1].score;
  }

  ProgressExam({
    required this.latestScore,
    required this.scoreRecords,
  });

  factory ProgressExam.fromJson(Map<String, dynamic> json) {
    var scoreRecordsFromJson = json['scoreRecords'] as List;
    List<ScoreRecord> scoreRecordsList = scoreRecordsFromJson.map((i) => ScoreRecord.fromJson(i)).toList();

    return ProgressExam(
      latestScore: json['latestScore'],
      scoreRecords: scoreRecordsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latestScore': latestScore,
      'scoreRecords': scoreRecords.map((e) => e.toJson()).toList(),
    };
  }
}