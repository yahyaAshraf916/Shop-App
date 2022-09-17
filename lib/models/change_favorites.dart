class ChangeFavorites {
  bool? status;
  String? message;
  ChangeFavorites.fromJason(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
