import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/auth_page.dart';

@RoutePage()
class ViewAuthRegisterPage extends StatefulWidget {
  final bool? backButton;

  const ViewAuthRegisterPage({this.backButton, Key? key}) : super(key: key);

  @override
  State<ViewAuthRegisterPage> createState() => _ViewAuthRegisterPageState();
}

class _ViewAuthRegisterPageState extends State<ViewAuthRegisterPage> {
  int segmentValue = 0;

  final List<bool> selectedBotton = [true, false];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 18,
          backgroundColor: Colors.white,
          leading: widget.backButton == true
              ? InkWell(
                  highlightColor: Colors.white,
                  onTap: () {
                    final router = AutoRouter.of(context).root; // гарантированно корень
                    // if (router.canPop()) {
                    //   router.pop();
                    // } else {
                    // на крайний случай — вернуться в лаунчер
                    context.read<AppBloc>().add(
                      const AppEvent.chageState(
                        // или changeTab(index: 4)
                        state: AppState.inAppUserState(index: 4),
                      ),
                    );
                    router.replaceAll([const LauncherRoute()]);
                    // }
                  },
                  child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 1.9),
                )
              : SizedBox.shrink(),
        ),
        body: AuthPage(),
      ),
    );
  }
}
