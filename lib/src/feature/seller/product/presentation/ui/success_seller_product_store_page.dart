import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_cubit.dart';
import 'package:haji_market/src/feature/seller/product/bloc/product_seller_cubit.dart';

@RoutePage()
class SuccessSellerProductStorePage extends StatefulWidget {
  const SuccessSellerProductStorePage({super.key});

  @override
  State<SuccessSellerProductStorePage> createState() => _SuccessSellerProductStorePageState();
}

class _SuccessSellerProductStorePageState extends State<SuccessSellerProductStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.icons.checkedSuccessIcon.path, height: 90, width: 90),
            SizedBox(height: 16),
            Text(
              'Товар успешно добавлен',
              style: AppTextStyles.size22Weight700.copyWith(color: Color(0xff0B0B0B)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Товар будет выставлен на продажу после \nпроверки',
              style: AppTextStyles.size16Weight400.copyWith(color: Color(0xff0B0B0B)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: InkWell(
          onTap: () {
            final router = AutoRouter.of(context).root;
            context.read<AppBloc>().add(
              const AppEvent.chageState(state: AppState.inAppAdminState(index: 1)),
            );

            router.replaceAll([const LauncherRoute()]);

            // Future.microtask(() {
            //   final productCubit = context.read<ProductSellerCubit>();
            //   productCubit
            //     ..resetState()
            //     ..products('');
            // });
          },
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.mainPurpleColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    'Добавить еще',
                    style: AppTextStyles.defaultButtonTextStyle.copyWith(color: AppColors.kWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
