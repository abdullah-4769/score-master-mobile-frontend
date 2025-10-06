// Add this new file: session_model.dart
import 'dart:convert';

class SessionModel {
  final int id;
  final String teamTitle;
  final String description;
  final String joinCode;
  final String joinLink;
  final String status;
  final int remainingTime;
  final int totalPlayers;
  final int engagement;
  final ActivePhase activePhase;
  final CreatedBy createdBy;
  final DateTime createdAt;

  SessionModel({
    required this.id,
    required this.teamTitle,
    required this.description,
    required this.joinCode,
    required this.joinLink,
    required this.status,
    required this.remainingTime,
    required this.totalPlayers,
    required this.engagement,
    required this.activePhase,
    required this.createdBy,
    required this.createdAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      teamTitle: json['teamTitle'],
      description: json['description'],
      joinCode: json['joinCode'],
      joinLink: json['joinLink'],
      status: json['status'],
      remainingTime: json['remainingTime'],
      totalPlayers: json['totalPlayers'],
      engagement: json['engagement'],
      activePhase: ActivePhase.fromJson(json['activePhase']),
      createdBy: CreatedBy.fromJson(json['createdBy']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamTitle': teamTitle,
      'description': description,
      'joinCode': joinCode,
      'joinLink': joinLink,
      'status': status,
      'remainingTime': remainingTime,
      'totalPlayers': totalPlayers,
      'engagement': engagement,
      'activePhase': activePhase.toJson(),
      'createdBy': createdBy.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class ActivePhase {
  final int id;
  final String name;
  final String status;
  final int remainingTime;

  ActivePhase({
    required this.id,
    required this.name,
    required this.status,
    required this.remainingTime,
  });

  factory ActivePhase.fromJson(Map<String, dynamic> json) {
    return ActivePhase(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      remainingTime: json['remainingTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'remainingTime': remainingTime,
    };
  }
}

class CreatedBy {
  final int id;
  final String name;
  final String role;

  CreatedBy({
    required this.id,
    required this.name,
    required this.role,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'],
      name: json['name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
    };
  }
}