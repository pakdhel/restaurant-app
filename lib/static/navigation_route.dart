enum NavigationRoute {
  homeRoute("/"),
  detailRoute("/detail"),
  favorite('/favorite');

  const NavigationRoute(this.name);
  final String name;
}
