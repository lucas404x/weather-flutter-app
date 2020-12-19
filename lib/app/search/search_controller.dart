import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class SearchController {
  final TextEditingController textEditingController;

  final _userInput = BehaviorSubject.seeded([]);

  final _suggestions = BehaviorSubject();
  Stream get suggestionsOutput => _suggestions.stream; 
  
  SearchController(this.textEditingController);

  void dispose() {
    _userInput.close();
    _suggestions.close();
  }
}
