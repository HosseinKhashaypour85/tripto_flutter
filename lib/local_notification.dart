import 'package:local_notifier/local_notifier.dart';

class LocalNotif {
  final String title;
  final String body;

  LocalNotif({
    required this.body,
    required this.title,
  });

  void showNotification() {
    final notification = LocalNotification(
      title: title,
      identifier: DateTime.now().millisecondsSinceEpoch.toString(), // شناسه منحصر به فرد برای هر اعلان
      body: body,
    );
    notification.show();
  }
}
