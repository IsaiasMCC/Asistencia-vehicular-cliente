part of 'local_storage_bloc.dart';

class LocalStorageEvent {
  LocalStorageEvent();
}

class UserAdded extends LocalStorageEvent {
  final dynamic user;
  UserAdded(this.user);
}
