class NavigationPayloadStore {
  final Map<String, Map<String, String>> _routePayloads = {};

  void save(String route, Map<String, String> parameters) {
    if (route.trim().isEmpty || parameters.isEmpty) return;
    _routePayloads[route] = Map<String, String>.from(parameters);
  }

  Map<String, String> read(String route) {
    final payload = _routePayloads[route];
    if (payload == null) return <String, String>{};
    return Map<String, String>.from(payload);
  }

  Map<String, String> consume(String route) {
    final payload = _routePayloads.remove(route);
    if (payload == null) return <String, String>{};
    return Map<String, String>.from(payload);
  }
}
