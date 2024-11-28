library my_async_value;

import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

/// AsyncValue
/// riverpod의 AsyncValue 간소화 버전
/// 네트워크 통신과 같은 값들을 bloc에서 처리할 때 사용
///
@sealed
@immutable
abstract class MyAsyncValue<T> {

}

/// AsyncValueState
/// AsyncValue의 상태를 클래스 대신 enum으로 정의
/// init - 초기 상태
/// loading - 통신 중 상태
/// success - 통신 성공
/// error - 통신 실패 200 외 응답 전부
enum AsyncValueState {
  init,
  loading,
  success,
  error;
}

class AsyncValue<T> {
  final AsyncValueState state;
  T? value;
  String?  error;
  String?  message;


  bool get hasValue => value != null;

  AsyncValue(
      this.value, {
        required this.state,
        this.error,
        this.message,
      });

  factory AsyncValue.init({T? value}) => AsyncValue(value, state: AsyncValueState.init);
  factory AsyncValue.loading({T? value}) => AsyncValue(value, state: AsyncValueState.loading);
  factory AsyncValue.success({T? value}) => AsyncValue(value, state: AsyncValueState.success);
  factory AsyncValue.error({T? value}) => AsyncValue(value, state: AsyncValueState.error);


  AsyncValue<T> asyncLoading({
    String? message,
  }) {
    return AsyncValue(
      value,
      state: AsyncValueState.loading,
      error: null,
      message: message,
    );
  }

  AsyncValue<T> asyncData({
    T? value,
    String? message,
  }) {
    return AsyncValue(
      value ?? this.value,
      state: AsyncValueState.success,
      error: null,
      message: message,
    );
  }

  AsyncValue<T> asyncError({
    String? error,
    String? message,
    T? value,
  }) {
    return AsyncValue(
      value ?? this.value,
      state: AsyncValueState.error,
      error: error,
      message: message,
    );
  }

  AsyncValue<T> copyWith({
    AsyncValueState? state,
    T? value,
    String? error,
    String? message,
  }) {
    return AsyncValue(
      value ?? this.value,
      state: state ?? this.state,
      error: error,
      message: message,
    );
  }

  @override
  String toString() {
    return 'AsyncValue{state: $state, value: $value, error: $error, message: $message}';
  }
}