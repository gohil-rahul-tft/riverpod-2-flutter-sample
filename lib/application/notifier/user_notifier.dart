import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod2_sample/application/state/user_state.dart';
import 'package:riverpod2_sample/utils/user_client.dart';

class UserNotifier extends StateNotifier<UserState> {
  final UserClient _userClient;

  UserNotifier(this._userClient) : super(const UserState());

  Future<void> getUserInfo(String userId) async {
    try {
      state = const UserState.loading();
      final userInfo = await _userClient.fetchUserInfo(userId);
      state = UserState.loaded(userInfo!);
    } catch (e) {
      debugPrint("ERROR : ${e.toString()}");
      state = UserState.error(message: 'Error fetching user info, id:$userId');
    }
  }
}
