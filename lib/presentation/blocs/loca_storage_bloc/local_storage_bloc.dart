import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  LocalStorageBloc() : super(const LocalStorageState()) {
    on<UserAdded>((event, emit) {
      emit(state.copyWith(
        user: event.user,
      ));
    });
  }

  dynamic setUser(dynamic user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user));
    add(UserAdded(user));
  }

  dynamic getUser(dynamic user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user') ?? '';
    return json.decode(user);
  }
}
