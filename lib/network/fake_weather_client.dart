import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeWeatherClient {
  Future<int> get(String cityName) async {
    await Future.delayed(const Duration(seconds: 2));
    return cityName == 'Texas' ? 18 : 21;
  }
}

final fakeWeatherClientProvider = Provider((ref) => FakeWeatherClient());

final responseProvider =
    FutureProvider.autoDispose.family<int, String>((ref, cityName) async {
  final weatherClient = ref.read(fakeWeatherClientProvider);
  return weatherClient.get(cityName);
});
