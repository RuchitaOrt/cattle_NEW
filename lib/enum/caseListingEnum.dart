enum CaseType {
  New,
  Pending,
  Unsynced,
  Complete,
   Expiring
}
enum LoanType {
  LOANEE,
  NON_LOANEE,
}
enum ProceedType {
  NLM,
  NON_NLM,
}


extension LoanTypeExtension on LoanType {
  String get displayName {
    switch (this) {
      case LoanType.LOANEE:
        return "LOANEE";
      case LoanType.NON_LOANEE:
        return "NON-LOANEE";
    }
  }
}
extension ProceedTypeExtension on ProceedType {
  String get procedName {
    switch (this) {
      case ProceedType.NLM:
        return "NLM";
      case ProceedType.NON_NLM:
        return "NON-NLM";
    }
  }
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