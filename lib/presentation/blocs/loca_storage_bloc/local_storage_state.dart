part of 'local_storage_bloc.dart';

class LocalStorageState {
  final dynamic user;
  const LocalStorageState({this.user});
  LocalStorageState copyWith({dynamic? user}) =>
      LocalStorageState(user: user ?? this.user);
}
