
class NotificationPayload {
  final String? title;
  final String? body;
  final Params? params;

  NotificationPayload({
    this.title,
    this.body,
    this.params,
  });

  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      NotificationPayload(
        title: json["title"],
        body: json["body"],
        params: (json["params"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "params": params,
      };
}

class Params {
  int? unreadNotices;
  int? unreadMessage;

  Params({
    this.unreadNotices,
    this.unreadMessage,
  });

  Params.fromJson(Map<String, dynamic> json) {
    unreadNotices = json['unread_notices'];
    unreadMessage = json['unread_messages'];
  }

  factory Params.fromString(dynamic json) {
    return Params(
      unreadNotices: json['unread_notices'],
      unreadMessage: json['unread_messages'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unread_notices'] = unreadNotices;
    data['unread_message'] = unreadMessage;
    return data;
  }
}
