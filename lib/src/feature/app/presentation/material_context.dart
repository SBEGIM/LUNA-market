// import 'package:flutter/material.dart';
// import 'package:haji_market/src/feature/app/presentaion/app_router_builder.dart';
// import 'package:haji_market/src/feature/app/router/app_router.dart';
// import 'package:study_line/src/core/constant/localization/localization.dart';
// import 'package:study_line/src/core/theme/resources.dart';
// import 'package:study_line/src/feature/app/presentation/widgets/app_router_builder.dart';
// import 'package:study_line/src/feature/app/router/app_router.dart';
// import 'package:study_line/src/feature/settings/widget/settings_scope.dart';

// /// [MaterialContext] is an entry point to the material context.
// ///
// /// This widget sets locales, themes and routing.
// class MaterialContext extends StatelessWidget {
//   const MaterialContext({super.key});

//   // This global key is needed for [MaterialApp]
//   // to work properly when Widgets Inspector is enabled.
//   // static final _globalKey = GlobalKey(debugLabel: 'MaterialContext');

//   @override
//   Widget build(BuildContext context) {
//     final settings = SettingsScope.settingsOf(context);
//     final mediaQueryData = MediaQuery.of(context);

//     return AppRouterBuilder(
//       createRouter: (context) => AppRouter(),
//       builder: (context, informationParser, routerDelegate, router) => MaterialApp.router(
//         title: 'Study Line',
//         onGenerateTitle: (context) => 'Study Line',
//         routerDelegate: routerDelegate,
//         routeInformationParser: informationParser,
//         theme: AppTheme.light,
//         darkTheme: AppTheme.light,
//         // theme: theme.lightTheme,
//         // darkTheme: theme.darkTheme,
//         // themeMode: ThemeMode.light, // theme.mode,
//         localizationsDelegates: Localization.localizationDelegates,
//         supportedLocales: Localization.supportedLocales,
//         locale: settings.locale,
//         // home: const HomeScreen(),
//         builder: (context, child) => MediaQuery(
//           // key: _globalKey,
//           data: mediaQueryData.copyWith(
//             textScaler: TextScaler.linear(
//               mediaQueryData.textScaler.scale(settings.textScale ?? 1).clamp(0.5, 2),
//             ),
//           ),
//           child: child!,
//         ),
//       ),
//     );
//   }
// }
