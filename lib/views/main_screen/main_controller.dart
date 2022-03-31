import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainController{
  MainController._private();
  static final instance = MainController._private();

  final pageIndex = BehaviorSubject<int>();

  PageController _pageController;
  AnimationController _bottomAppBarController;

  void dispose(){
    print("dispose");
    pageIndex.close();
    _pageController.dispose();
    _bottomAppBarController.dispose();
  }

  void initPageController(PageController controller, AnimationController bottomAppBarController){
    _pageController = controller;
    _bottomAppBarController = bottomAppBarController;
  }

}