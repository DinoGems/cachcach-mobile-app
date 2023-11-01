class ApiPath {
  static const String login = "/v1/auth/login";
  static const String logout = "/v1/auth/logout";
  static const String gameModes = "/v1/game-modes";

  static String gameModeCategories(int? id) {
    return "/v1/game-modes/$id/categories";
  }
}
