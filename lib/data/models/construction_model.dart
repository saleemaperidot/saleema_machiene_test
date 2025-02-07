class ConstructionModel {
  final int? id;
  final String name;
  final String location;
  final String startDate;
  final String endDate;
  final String status;

  ConstructionModel({
    this.id,
    required this.name,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }

  // Create ProjectModel from Map
  factory ConstructionModel.fromMap(Map<String, dynamic> map) {
    return ConstructionModel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      status: map['status'],
    );
  }
}
