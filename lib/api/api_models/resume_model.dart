class ResumeModel {
  int? id;
  int? gameFormatId;
  String? description;
  int? createdById;
  String? joinCode;
  String? joiningLink;
  String? status;
  int? duration;
  int? elapsedTime;
  String? startedAt;
  Null? pausedAt;
  Null? endedAt;
  String? createdAt;
  String? updatedAt;

  ResumeModel(
      {this.id,
        this.gameFormatId,
        this.description,
        this.createdById,
        this.joinCode,
        this.joiningLink,
        this.status,
        this.duration,
        this.elapsedTime,
        this.startedAt,
        this.pausedAt,
        this.endedAt,
        this.createdAt,
        this.updatedAt});

  ResumeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameFormatId = json['gameFormatId'];
    description = json['description'];
    createdById = json['createdById'];
    joinCode = json['joinCode'];
    joiningLink = json['joiningLink'];
    status = json['status'];
    duration = json['duration'];
    elapsedTime = json['elapsedTime'];
    startedAt = json['startedAt'];
    pausedAt = json['pausedAt'];
    endedAt = json['endedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gameFormatId'] = this.gameFormatId;
    data['description'] = this.description;
    data['createdById'] = this.createdById;
    data['joinCode'] = this.joinCode;
    data['joiningLink'] = this.joiningLink;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['elapsedTime'] = this.elapsedTime;
    data['startedAt'] = this.startedAt;
    data['pausedAt'] = this.pausedAt;
    data['endedAt'] = this.endedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
class StartModel {
  int? id;
  int? gameFormatId;
  String? description;
  int? createdById;
  String? joinCode;
  String? joiningLink;
  String? status;
  int? duration;
  int? elapsedTime;
  String? startedAt;
  Null? pausedAt;
  Null? endedAt;
  String? createdAt;
  String? updatedAt;

  StartModel(
      {this.id,
        this.gameFormatId,
        this.description,
        this.createdById,
        this.joinCode,
        this.joiningLink,
        this.status,
        this.duration,
        this.elapsedTime,
        this.startedAt,
        this.pausedAt,
        this.endedAt,
        this.createdAt,
        this.updatedAt});

  StartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameFormatId = json['gameFormatId'];
    description = json['description'];
    createdById = json['createdById'];
    joinCode = json['joinCode'];
    joiningLink = json['joiningLink'];
    status = json['status'];
    duration = json['duration'];
    elapsedTime = json['elapsedTime'];
    startedAt = json['startedAt'];
    pausedAt = json['pausedAt'];
    endedAt = json['endedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gameFormatId'] = this.gameFormatId;
    data['description'] = this.description;
    data['createdById'] = this.createdById;
    data['joinCode'] = this.joinCode;
    data['joiningLink'] = this.joiningLink;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['elapsedTime'] = this.elapsedTime;
    data['startedAt'] = this.startedAt;
    data['pausedAt'] = this.pausedAt;
    data['endedAt'] = this.endedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
class PauseModel {
  int? id;
  int? gameFormatId;
  String? description;
  int? createdById;
  String? joinCode;
  String? joiningLink;
  String? status;
  int? duration;
  int? elapsedTime;
  Null? startedAt;
  String? pausedAt;
  Null? endedAt;
  String? createdAt;
  String? updatedAt;

  PauseModel(
      {this.id,
        this.gameFormatId,
        this.description,
        this.createdById,
        this.joinCode,
        this.joiningLink,
        this.status,
        this.duration,
        this.elapsedTime,
        this.startedAt,
        this.pausedAt,
        this.endedAt,
        this.createdAt,
        this.updatedAt});

  PauseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameFormatId = json['gameFormatId'];
    description = json['description'];
    createdById = json['createdById'];
    joinCode = json['joinCode'];
    joiningLink = json['joiningLink'];
    status = json['status'];
    duration = json['duration'];
    elapsedTime = json['elapsedTime'];
    startedAt = json['startedAt'];
    pausedAt = json['pausedAt'];
    endedAt = json['endedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gameFormatId'] = this.gameFormatId;
    data['description'] = this.description;
    data['createdById'] = this.createdById;
    data['joinCode'] = this.joinCode;
    data['joiningLink'] = this.joiningLink;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['elapsedTime'] = this.elapsedTime;
    data['startedAt'] = this.startedAt;
    data['pausedAt'] = this.pausedAt;
    data['endedAt'] = this.endedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}