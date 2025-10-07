class CreateGameModel {
  String? name;
  String? description;
  String? mode;
  int? totalPhases;
  int? timeDuration;
  int? createdById;
  List<int>? facilitatorIds;

  CreateGameModel(
      {this.name,
        this.description,
        this.mode,
        this.totalPhases,
        this.timeDuration,
        this.createdById,
        this.facilitatorIds});

  CreateGameModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    mode = json['mode'];
    totalPhases = json['totalPhases'];
    timeDuration = json['timeDuration'];
    createdById = json['createdById'];
    facilitatorIds = json['facilitatorIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['mode'] = this.mode;
    data['totalPhases'] = this.totalPhases;
    data['timeDuration'] = this.timeDuration;
    data['createdById'] = this.createdById;
    data['facilitatorIds'] = this.facilitatorIds;
    return data;
  }
}
