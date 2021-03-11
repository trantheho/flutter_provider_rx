import 'package:flutter_provider_rx/base/base_provider.dart';
import 'package:flutter_provider_rx/models/book_model.dart';

class BookProvider extends BaseProvider{

  List<Book> _popular = [];
  List<Book> get listPopular => _popular;

  set updatePopular(List<Book> books){
    _popular = books;
    notify();
  }

  void updateFavorite(String id, bool value){
    listPopular.forEach((element) {
      if(element.id == id)
        element.bookmark = value;
    });
    notify();
  }


}