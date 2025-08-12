import 'package:cattle/Screens/NoFilterScreen.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  int selectedTabIndex = 0;
  DateTime? fromDate;
  DateTime? toDate;

  final List<String> tabs = [
    "Date",
    "Village",
    "Animal",
    "Category",
    "Type",
    "Status",
    "Animals tagged",
  ];

  final Map<String, Set<String>> selectedOptions = {
    "Village": {},
    "Animal": {},
    "Category": {},
    "Type": {},
    "Status": {},
    "Animals tagged": {},
  };

  final Map<String, List<String>> options = {
    "Village": ["Bhikewpur", "Hingno", "Kuhi", "Mouda"],
    "Animal": ["Cow", "Buffalo"],
    "Category": ["NLM", "Non-NLM"],
    "Type": ["Loanee", "Non-Loanee"],
    "Status": ["Denied", "Payment pending", "CKYC pending"],
    "Animals tagged": [
      "0 of 10", "1 of 10", "2 of 10", "3 of 10", "4 of 10",
      "5 of 10", "6 of 10", "7 of 10", "8 of 10", "9 of 10", "10 of 10"
    ],
  };
TextEditingController fromController=TextEditingController();
TextEditingController toController=TextEditingController();
  List<String> result = ["r"]; // Used to control visibility in UI

  void selectTab(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context, bool isFrom) async {
    final initial = isFrom ? (fromDate ?? DateTime.now()) : (toDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      if (isFrom) {
        setFromDate(picked);
      } else {
        setToDate(picked);
      }
    }
  }
  void setTabIndex(int index) {
  selectedTabIndex = index;
  notifyListeners();
}


  void toggleOption(String key, String value) {
    final set = selectedOptions[key]!;
    if (set.contains(value)) {
      set.remove(value);
    } else {
      set.add(value);
    }
    notifyListeners();
  }

  void resetFilters() {
    fromController.text="";
    toController.text="";
    toDate = null;
    result = []; // Hide results section again
    selectedOptions.forEach((key, value) => value.clear());
    notifyListeners();
  }

  void applyFilters() {
    final filters = getAppliedFilters();
    print("Applied Filters: $filters");
    Navigator.of(
                routeGlobalKey.currentContext!,
              ).pushNamedAndRemoveUntil(
                NoFilterScreen.route,
                (route) => false,
              );
    // Show the result section now
    // result.clear();
    notifyListeners();
  }

  Map<String, dynamic> getAppliedFilters() {
    return {
      "fromDate": fromDate?.toIso8601String(),
      "toDate": toDate?.toIso8601String(),
      ...selectedOptions.map((key, value) => MapEntry(key, value.toList())),
    };
  }

  String formatDate(DateTime? date) {
    if (date == null) return "Select date";
    return "${date.day.toString().padLeft(2, '0')} ${_month(date.month)} ${date.year}";
  }

  String _month(int m) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[m - 1];
  }
  TextEditingController villageSearchController = TextEditingController();
String villageSearchTerm = '';

void updateVillageSearch(String value) {
  villageSearchTerm = value.toLowerCase();
  notifyListeners();
}
List<String> getFilteredVillageOptions() {
  if (villageSearchTerm.isEmpty) {
    return options["Village"] ?? [];
  } else {
    return (options["Village"] ?? [])
        .where((v) => v.toLowerCase().contains(villageSearchTerm))
        .toList();
  }
}

}
