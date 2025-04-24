import 'dart:math';

class TripIdGenerator {
  String tripIdGenerator({int length = 5}) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
