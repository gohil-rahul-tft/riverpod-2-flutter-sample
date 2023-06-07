import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod2_sample/application/notifier/user_notifier.dart';
import 'package:riverpod2_sample/utils/user_client.dart';

import 'application/state/user_state.dart';

final userClientProvider = Provider((ref) => UserClient());

final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(ref.watch(userClientProvider)),
);
