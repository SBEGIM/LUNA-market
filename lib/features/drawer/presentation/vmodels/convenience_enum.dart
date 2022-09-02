import 'package:flutter/material.dart';

enum Conveniences {
  gadjets,
  aksesuars,
  smartphones,
  radio,
}

extension ConvenienceExtension on Conveniences? {
  static List<Conveniences> get conveniences {
    return [
      Conveniences.gadjets,
      Conveniences.aksesuars,
      Conveniences.smartphones,
      Conveniences.radio,
    ];
  }

  String get label {
    String label = '';
    if (this == Conveniences.gadjets) {
      label = 'Гаджеты';
    } else if (this == Conveniences.aksesuars) {
      label = 'Аксесуары';
    } else if (this == Conveniences.smartphones) {
      label = 'Смартфоны';
    } else if (this == Conveniences.radio) {
      label = 'Радио';
    }
    return label;
  }

  static String listToString(List<Conveniences?>? conveniences) {
    if (conveniences == null || conveniences.isEmpty) {
      return '';
    } else if (conveniences.length == 1) {
      return conveniences.first.label;
    } else {
      final String label = conveniences.first.label;
      conveniences.remove(conveniences.first);
      return "$label, ${listToString(conveniences)}";
    }
  }

  static List<Conveniences?> stringToList(String? string) {
    if (string == '') {
      return [];
    } else {
      final List<Conveniences?> conveniences = [];
      final List<String> parts = string!.split(', ');
      for (final String part in parts) {
        conveniences.add(fromLabel(part));
      }
      return conveniences;
    }
  }

  static Conveniences? fromLabel(String label) {
    Conveniences? convenience;
    if (label == 'Гаджеты') {
      convenience = Conveniences.gadjets;
    } else if (label == 'Аксесуары') {
      convenience = Conveniences.aksesuars;
    } else if (label == 'Смартфоны') {
      convenience = Conveniences.smartphones;
    } else if (label == 'Радио') {
      convenience = Conveniences.radio;
    }
    return convenience;
  }
}
