import 'dart:math';

int generateRandomPrice({required bool isRoundTrip}) {
  final Random random = Random();
  int basePrice = 500000 + random.nextInt(1000000);
  return isRoundTrip ? basePrice * 2 : basePrice;
}
