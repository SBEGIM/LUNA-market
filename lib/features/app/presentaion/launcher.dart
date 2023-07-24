import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/features/app/bloc/app_bloc.dart';
import 'package:haji_market/features/app/presentaion/base_new.dart';
import 'package:haji_market/features/app/widgets/custom_loading_widget.dart';
import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';

@RoutePage(name: 'LauncherRoute')
class LauncherApp extends StatefulWidget {
  const LauncherApp({super.key});
  @override
  State<LauncherApp> createState() => _LauncherAppState();
}

class _LauncherAppState extends State<LauncherApp> {
  @override
  void initState() {
    BlocProvider.of<AppBloc>(context).add(const AppEvent.checkAuth());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        state.whenOrNull(
            // inAppState: () {
            //   BlocProvider.of<ProfileBLoC>(context).add(const ProfileEvent.getProfile());
            //   BlocProvider.of<AppBloc>(context).add(const AppEvent.sendDeviceToken());
            // },
            // errorState: (message) {
            //   buildErrorCustomSnackBar(context, 'AppBloc => $message');
            // },
            );
      },
      builder: (context, state) {
        return state.maybeWhen(
          notAuthorizedState: () => const ViewAuthRegisterPage(),
          loadingState: () => const _Scaffold(child: CustomLoadingWidget()),
          orElse: () => const BaseNew(),
        );
      },
    ); // OnBoardingPage();
  }
}

class _Scaffold extends StatelessWidget {
  final Widget child;
  const _Scaffold({
    required this.child,
    // super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: child),
    );
  }
}
