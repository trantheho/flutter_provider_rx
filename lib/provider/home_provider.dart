import 'package:flutter/foundation.dart';
import 'package:flutter_provider_rx/models/book_model.dart';

class HomeProvider extends ChangeNotifier{
  String _currentTabName = 'popular';
  String get currentTabName => _currentTabName;

  HomeProvider._(List<Book> popularData){
    _popular = [...popularData];
  }

  List<Book> _popular = [];
  List<Book> get popularList => _popular;

  set updateTabName(String name){
    _currentTabName = name;
    notifyListeners();
  }

  set updatePopular(List<Book> books){
    _popular = books;
    notifyListeners();
  }

  void updateFavorite(String id, bool value){
    for (var element in popularList) {
      if(element.id == id) {
        element.bookmark = value;
      }
    }
    notifyListeners();
  }

  static HomeProvider init(){
    return HomeProvider._([]);
  }
}