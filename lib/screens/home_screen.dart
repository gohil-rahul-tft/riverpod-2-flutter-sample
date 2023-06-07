import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod2_sample/application/state/user_state.dart';
import 'package:riverpod2_sample/providers.dart';
import 'package:riverpod2_sample/network/fake_weather_client.dart';
import 'package:riverpod2_sample/notifier/counter_notifier.dart';

TextStyle textStyle =
    const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
final welcomeProvider = Provider((ref) => 'Welcome to Riverpod');

final counterProvider = ChangeNotifierProvider((ref) => CounterNotifier());

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final welcomeString = ref.watch(welcomeProvider);
    final counterNotifier = ref.watch(counterProvider);
    final responseValue = ref.watch(responseProvider("Texas"));
    final apiResponse = ref.watch(userNotifierProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(welcomeString, style: textStyle),
            Text("Counter ${counterNotifier.value}", style: textStyle),
            const SizedBox(height: 8),
            responseValue.when(
              data: (weather) => Text('$weather', style: textStyle),
              error: (message, stack) => Text(message.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
            apiResponse.when(
              () => Container(),
              loading: () => const CircularProgressIndicator(),
              loaded: (user) {
                debugPrint("USER : ${user.toString()}");
                return Text(
                  "Welcome ${user.data.firstName} ${user.data.lastName}",
                  style: textStyle,
                );
              },
              error: (message) => Text(message.toString()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterNotifier.incrementValue();
          ref.read(userNotifierProvider.notifier).getUserInfo("2");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
