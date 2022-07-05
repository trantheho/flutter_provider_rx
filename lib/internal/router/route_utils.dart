
enum AppPage{
  splash,
  error,
  root,
  home,
  store,
  bag,
  profile,
  login,
  register,
  book,
  book2,
}

extension AppPageExtension on AppPage{
  String get path{
    switch(this){
      case AppPage.error:
        return "/error";
      case AppPage.splash:
        return "/splash";
      case AppPage.root:
        return "/";
      case AppPage.register:
        return "/register";
      case AppPage.login:
        return "/login";
      case AppPage.home:
        return "/home";
      case AppPage.book:
        return "book/:bookId";
      case AppPage.store:
        return "/store";
      case AppPage.bag:
        return "/bag";
      case AppPage.profile:
        return "/profile";
      case AppPage.book2:
        return "new/:book2Id";
      default:
        return "/";
    }
  }

  String get param{
    switch(this){
      case AppPage.book:
        return "bookId";
      case AppPage.book2:
        return "book2Id";
      default:
        return "";
    }
  }

  String get name{
    switch(this){
      case AppPage.splash:
        return "splash";
      case AppPage.error:
        return "error";
      case AppPage.home:
        return "home";
      case AppPage.login:
        return "login";
      case AppPage.register:
        return "register";
      case AppPage.root:
        return "root";
      case AppPage.book:
        return "book";
      case AppPage.book2:
        return "new";
      case AppPage.store:
        return "store";
      case AppPage.bag:
        return "bag";
      case AppPage.profile:
       return "profile";
      default:
        return "root";
    }
  }
}