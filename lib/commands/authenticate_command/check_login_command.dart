import 'package:flutter_provider_rx/commands/base_command.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/models/user_model.dart';

class CheckLoginCommand extends BaseCommand{
  Future<bool> run() async {
    await Future.delayed(const Duration(seconds: 2));
    final _user = User(name: "Chicken", age: "2", phone: "00000000");
    mainProvider.updateCurrentUser = _user;
    mainProvider.homeData.updatePopular = [
      Book(
        id: "0",
        image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
        name: "Tây Du",
        subName: "The Ton Ngo Khong",
        bookmark: true,
      ),
      Book(
        id: "1",
        image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
        name: "Vũ Canh Kỷ",
        subName: "The Vu Canh",
        bookmark: false,
      ),
      Book(
        id: "2",
        image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
        name: "Nguyên Long",
        subName: "The Thor",
        bookmark: false,
      ),
    ];

    return true;
  }
}