
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
        return "/home/:kind";
      case AppPage.book:
        return "book/:bookId";
      case AppPage.store:
        return "/store";
      case AppPage.bag:
        return "/bag";
      case AppPage.profile:
        return "/profile";
      default:
        return "/";
    }
  }

  String get param{
    switch(this){
      case AppPage.home:
        return "kind";
      case AppPage.book:
        return "bookId";
      default:
        return "kind";
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