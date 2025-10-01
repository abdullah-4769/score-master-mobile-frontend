class AddPhaseModel {
  int? gameFormatId;
  String? name;
  String? description;
  int? order;
  String? scoringType;
  int? timeDuration;
  List<String>? challengeTypes;
  String? difficulty;
  String? badge;
  int? requiredScore;
  AddPhaseModel(
      {this.gameFormatId,
        this.name,
        this.description,
        this.order,
        this.scoringType,
        this.timeDuration,
        this.challengeTypes,
        this.difficulty,
        this.badge,
        this.requiredScore});

  AddPhaseModel.fromJson(Map<String, dynamic> json) {
    gameFormatId = json['gameFormatId'];
    name = json['name'];
    description = json['description'];
    order = json['order'];
    scoringType = json['scoringType'];
    timeDuration = json['timeDuration'];
    challengeTypes = json['challengeTypes'].cast<String>();
    difficulty = json['difficulty'];
    badge = json['badge'];
    requiredScore = json['requiredScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gameFormatId'] = this.gameFormatId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['order'] = this.order;
    data['scoringType'] = this.scoringType;
    data['timeDuration'] = this.timeDuration;
    data['challengeTypes'] = this.challengeTypes;
    data['difficulty'] = this.difficulty;
    data['badge'] = this.badge;
    data['requiredScore'] = this.requiredScore;
    return data;
  }
}
