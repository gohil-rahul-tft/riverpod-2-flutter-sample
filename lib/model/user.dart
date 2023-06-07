import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod2_sample/model/user_data.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "data") required UserData data,
  }) = _User;



  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}