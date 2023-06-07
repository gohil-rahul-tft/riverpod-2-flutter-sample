import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod2_sample/model/user.dart';

part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(User user) = _UserData;
  const factory UserState.error({required String message}) = _Error;
}