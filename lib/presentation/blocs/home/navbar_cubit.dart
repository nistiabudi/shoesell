import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';

class NavbarCubit extends Cubit<int> {
  final PageController controller = PageController();
  NavbarCubit() : super(0);

  void update(int value) {
    emit(value);
  }
}
