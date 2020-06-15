import 'package:flutter/material.dart';
import 'package:flutter_reader/bean/FPage.dart';

class ReaderModule with ChangeNotifier {
  List<FPage> _pages = [new FPage()];
  List<FPage> get value => _pages;

  void setInitPages(List<FPage> pages) {
    _pages.addAll(pages);
  }

  void addNewPages(List<FPage> pages) {
    _pages.addAll(pages);
    notifyListeners();
  }
}