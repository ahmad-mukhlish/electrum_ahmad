enum MainNavDestination {
  home(path: '/', idx: 0),
  bikes(path: '/bikes', idx: 1),
  profile(path: '/profile', idx: 2);

  const MainNavDestination({required this.path, required this.idx});

  final String path;
  final int idx;

  static MainNavDestination fromIndex(int index) {
    switch (index) {
      case 1:
        return MainNavDestination.bikes;
      case 2:
        return MainNavDestination.profile;
      case 0:
      default:
        return MainNavDestination.home;
    }
  }

  static MainNavDestination fromPath(String path) {
    switch (path) {
      case '/bikes':
        return MainNavDestination.bikes;
      case '/profile':
        return MainNavDestination.profile;
      case '/':
      default:
        return MainNavDestination.home;
    }
  }
}
