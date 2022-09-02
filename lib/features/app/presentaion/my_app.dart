import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/admin/admin_app/bloc/admin_navigation_cubit/admin_navigation_cubit.dart';
import 'package:haji_market/admin/admin_app/presentation/base_admin.dart';
import 'package:haji_market/features/app/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/auth/presentation/ui/select_country_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => AdminNavigationCubit()),
      ],
      child: MaterialApp(
        title: 'Haji Market',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
// const BaseAdmin()
            // SelectCountryPage()
            const Base(),
      ),
    );
  }
}
