enum PhaseStatus { pending, active, completed }

class PhaseUIModel {
  final int id;
  final String name;
  final int order;
  final int timeDuration;
  PhaseStatus status;

  PhaseUIModel({
    required this.id,
    required this.name,
    required this.order,
    required this.timeDuration,
    this.status = PhaseStatus.pending,
  });

  factory PhaseUIModel.fromJson(Map<String, dynamic> json) {
    return PhaseUIModel(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      timeDuration: json['timeDuration'] ?? 0,
    );
  }
}
