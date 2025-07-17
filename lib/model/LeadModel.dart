class LeadModel {
  final String name;
  final String tag;
  final String village;
  final String date;
  final String status;
  final String daysLeft;
  final String? imageUrl;
  final String? scheduleText;
  final String? buttonText;

  LeadModel({
    required this.name,
    required this.tag,
    required this.village,
    required this.date,
    required this.status,
    required this.daysLeft,
    this.imageUrl,
    this.scheduleText,
    this.buttonText,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
      village: json['village'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      daysLeft: json['daysLeft'] ?? '',
      imageUrl: json['imageUrl'],
      scheduleText: json['scheduleText'],
      buttonText: json['buttonText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tag': tag,
      'village': village,
      'date': date,
      'status': status,
      'daysLeft': daysLeft,
      'imageUrl': imageUrl,
      'scheduleText': scheduleText,
      'buttonText': buttonText,
    };
  }
}
