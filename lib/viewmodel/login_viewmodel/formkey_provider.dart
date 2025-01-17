import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormKeyProvider extends StateNotifier<GlobalKey<FormState>> {
  FormKeyProvider() : super(GlobalKey<FormState>());
}

final formKeyProvider =
    StateNotifierProvider<FormKeyProvider, GlobalKey<FormState>>(
  (ref) => FormKeyProvider(),
);
