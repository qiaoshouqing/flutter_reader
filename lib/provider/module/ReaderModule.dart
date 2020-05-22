import 'package:flutter/material.dart';
import 'package:flutter_reader/bean/Page.dart';

class ReaderModule with ChangeNotifier {
  List<Page> _pages = [new Page()];
  List<Page> get value => _pages;

  void setInitPages(List<Page> pages) {
    _pages.addAll(pages);
  }

  void addNewPages(List<Page> pages) {
    _pages.addAll(pages);
    notifyListeners();
  }
}