enum CaseType {
  New,
  Pending,
  Unsynced,
  Complete,
}
class CaseItem {
  final String name;
  final String location;
  final String date;
  final String status;
  final String action;
  final bool showAction;

  CaseItem({
    required this.name,
    required this.location,
    required this.date,
    required this.status,
    required this.action,
    required this.showAction,
  });
}