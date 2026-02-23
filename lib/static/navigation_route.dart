enum NavigationRoute {
  homeRoute("/"),
  detailRoute("/detail"),
  favorite('/favorite'),
  setting('/setting');

  const NavigationRoute(this.name);
  final String name;
}
