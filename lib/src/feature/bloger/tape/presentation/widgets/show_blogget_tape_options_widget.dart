import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/upload_video_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/data/model/tape_blogger_model.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/ui/tape_statistics_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showBlogerTapeOptions(BuildContext context, int id, TapeBloggerModel tape) {
  final rootContext = context;

  showMaterialModalBottomSheet(
    context: rootContext,
    backgroundColor: AppColors.kBackgroundColor,
    // isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500, minHeight: 278),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Заголовок и крестик
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Управление видео', style: AppTextStyles.size16Weight500),
                      InkWell(
                        onTap: () => Navigator.of(sheetContext).pop(),
                        child: Image.asset(
                          Assets.icons.defaultCloseIcon.path,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    rootContext.router.push(EditTapeVideoRoute(id: id));
                  },
                  child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.kGray, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(Assets.icons.editIcon.path, height: 18, width: 18),
                        SizedBox(width: 12),
                        Text('Редактировать', style: AppTextStyles.size16Weight500),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(sheetContext).pop();

                    Navigator.push(
                      rootContext,
                      MaterialPageRoute(
                        builder: (context) => TapeStatisticsPage(tape: tape),
                      ),
                    );
                  },
                  child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.kGray, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(Assets.icons.statisticsIcon.path, height: 18, width: 18),
                        SizedBox(width: 12),
                        Text('Статистика', style: AppTextStyles.size16Weight500),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // 1) Закрыли bottom sheet
                    Navigator.of(sheetContext).pop();

                    // 2) Показали подтверждение через ЖИВОЙ контекст (rootContext), не через sheetContext
                    Future.microtask(() async {
                      final ok = await showAccountAlert(
                        context,
                        title: 'Удаление видео обзора',
                        message: 'Вы уверены, что хотите удалить видео обзор?',
                        mode: AccountAlertMode.confirm,
                        cancelText: 'Отмена',
                        primaryText: 'Да',
                        primaryColor: Colors.red,
                      );

                      if (ok == true) {
                        await rootContext.read<UploadVideoBLoggerCubit>().delete(tapeId: id);

                        final router = AutoRouter.of(context).root;

                        context.read<AppBloc>().add(
                          const AppEvent.chageState(state: AppState.inAppBlogerState(index: 1)),
                        );
                        router.replaceAll([const LauncherRoute()]);
                        AppSnackBar.show(
                          context,
                          'Удаление видео обзора успешно',
                          type: AppSnackType.success,
                        );
                      }
                      if (ok == false) {}
                    });
                  },
                  child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.kGray, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(Assets.icons.trashIcon.path, height: 18, width: 18),
                        SizedBox(width: 12),
                        Text(
                          'Удалить',
                          style: AppTextStyles.size16Weight500.copyWith(color: Color(0xFFFF3347)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    },
  );
}
