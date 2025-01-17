import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectConditionBorderProvider extends StateNotifier<Color> {
  SelectConditionBorderProvider() : super(const Color(0xFFE5E7EB));

  void setBorderColorNew() {
    state = const Color(0xFF6B4EFF);
  }

  void setBorderColorUsed() {
    state = const Color(0xFFE5E7EB);
  }
}

final selectConditionBorderProvider =
    StateNotifierProvider<SelectConditionBorderProvider, Color>(
        (ref) => SelectConditionBorderProvider());
