// lib/providers/search_provider.dart
import 'package:cattle/model/LeadModel.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  List<String> allNames = [
    "Sohlesh Sonewat", "Ananya Gupta", "Rajesh Kumar",
    "Priya Desai", "Vikram Singh", "Amit Verma", "Neha Sharma", "People Ready"
  ];

  List<String> recentSearches = [
    "Sohlesh Sonewat", "Sohlesh Sonewat", "Ananya Gupta",
    "Rajesh Kumar", "Priya Desai", "Vikram Singh"
  ];
  final List<LeadModel> yourLeadsListing = [
    LeadModel(name: "Sohlesh Sonewat", tag: ["NON-NLM", "NON-LOANEE"], village: "Khushdeva", date: "29 Apr '25", status: "Reschedule", statusShown: "Pending", daysLeft: "2 Days left", scheduleText: "Schedule", buttonText: "Start"),
    LeadModel(name: "Ananya Gupta", tag: ["NON-NLM", "NON-LOANEE"], village: "Khushdeva", date: "29 Apr '25", status: "Reschedule", statusShown: "Pending", daysLeft: "2 Days left", scheduleText: "Schedule", buttonText: "Start"),
    LeadModel(name: "Priya Desai", tag: ["NON-NLM", "NON-LOANEE"], village: "Khushdeva", date: "29 Apr '25", status: "Reschedule", statusShown: "Pending", daysLeft: "2 Days left", scheduleText: "Schedule", buttonText: "Start"),
    LeadModel(name: "Vikram Sing", tag: ["NON-NLM", "NON-LOANEE"], statusShown: "Pending", village: "Khushdeva", date: "29 Apr '25", status: "Pending", daysLeft: "", scheduleText: "Schedule", buttonText: "Start"),
  ];

  List<String> searchResults = [];
  bool showResults = false;
  String? selectedName;

  void performSearch(String query) {
    selectedName = null;

    if (query.trim().isEmpty) {
      searchResults = [];
      showResults = false;
    } else {
      searchResults = allNames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      showResults = true;
    }
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    selectedName=null;
    showResults = false;
    notifyListeners();
  }

  void selectRecent(String name) {
    searchController.text = name;
    performSearch(name);
  }

  void selectResult(String name) {
    selectedName = name;
    notifyListeners();
  }
}
