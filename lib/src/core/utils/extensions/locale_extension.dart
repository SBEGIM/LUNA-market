import 'package:flutter/material.dart';

extension LocaleExtension on Locale {
  R when<R>({required R Function() kk, required R Function() ru, required R Function() en}) =>
      switch (languageCode) {
        'kk' => kk(),
        'ru' => ru(),
        'en' => en(),
        _ => kk(),
      };

  T whenByValue<T extends Object?>({required T kk, required T ru, required T en}) =>
      switch (languageCode) {
        'kk' => kk,
        'ru' => ru,
        'en' => en,
        _ => kk,
      };
}
