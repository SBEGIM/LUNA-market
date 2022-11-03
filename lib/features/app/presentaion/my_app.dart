import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/admin_app/bloc/admin_navigation_cubit/admin_navigation_cubit.dart';
import 'package:haji_market/admin/auth/data/bloc/login_admin_cubit.dart';
import 'package:haji_market/admin/auth/data/repository/LoginAdminRepo.dart';
import 'package:haji_market/admin/my_orders_admin/data/bloc/basket_admin_cubit.dart';
import 'package:haji_market/admin/my_orders_admin/data/repository/basket_admin_repo.dart';
import 'package:haji_market/features/app/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/auth/data/bloc/login_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/brand_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/favorite_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/shops_drawer_cubit.dart';
import 'package:haji_market/features/drawer/data/repository/BrandRepo.dart';
import 'package:haji_market/features/drawer/data/repository/SubCatsRepo.dart';
import 'package:haji_market/features/drawer/data/repository/basket_repo.dart';
import 'package:haji_market/features/drawer/data/repository/favorite_repo.dart';
import 'package:haji_market/features/drawer/data/repository/shops_drawer_repo.dart';
import 'package:haji_market/features/home/data/bloc/banners_cubit.dart';
import 'package:haji_market/features/home/data/repository/CatsRepo.dart';
import 'package:haji_market/features/home/data/repository/Popular_shops_repo.dart';

import '../../../admin/my_products_admin/data/bloc/product_admin_cubit.dart';
import '../../../admin/my_products_admin/data/repository/ProductAdminRepo.dart';
import '../../auth/data/bloc/register_cubit.dart';
import '../../auth/data/bloc/sms_cubit.dart';
import '../../auth/data/repository/LoginRepo.dart';
import '../../auth/data/repository/registerRepo.dart';
import '../../auth/presentation/ui/view_auth_register_page.dart';
import '../../drawer/data/bloc/basket_cubit.dart';
import '../../drawer/data/bloc/product_cubit.dart';
import '../../drawer/data/bloc/sub_cats_cubit.dart';
import '../../drawer/data/repository/product_repo.dart';
import '../../home/data/bloc/cats_cubit.dart';
import '../../home/data/bloc/popular_shops_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool token = GetStorage().hasData('token');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => AdminNavigationCubit()),
        BlocProvider(
            create: (_) => LoginCubit(loginRepository: LoginRepository())),
        BlocProvider(
            create: (_) => SmsCubit(registerRepository: RegisterRepository())),
        BlocProvider(
            create: (_) =>
                RegisterCubit(registerRepository: RegisterRepository())),
        BlocProvider(
            create: (_) => CatsCubit(listRepository: ListRepository())),
        BlocProvider(
            create: (_) => SubCatsCubit(subCatRepository: SubCatsRepository())),
        BlocProvider(
            create: (_) => BannersCubit(listRepository: ListRepository())),
        BlocProvider(
            create: (_) => PopularShopsCubit(
                popularShopsRepository: PopularShopsRepository())),
        BlocProvider(
            create: (_) => ShopsDrawerCubit(
                shopsDrawerRepository: ShopsDrawerRepository())),
        BlocProvider(
            create: (_) =>
                ProductCubit(productRepository: ProductRepository())),
        BlocProvider(
            create: (_) =>
                FavoriteCubit(favoriteRepository: FavoriteRepository())),
        BlocProvider(
            create: (_) => BasketCubit(basketRepository: BasketRepository())),
        BlocProvider(
            create: (_) => BrandCubit(brandRepository: BrandsRepository())),
        BlocProvider(
            create: (_) =>
                LoginAdminCubit(loginAdminRepository: LoginAdminRepository())),
        BlocProvider(
            create: (_) => ProductAdminCubit(
                productAdminRepository: ProductAdminRepository())),
        BlocProvider(
            create: (_) =>
                BasketAdminCubit(basketRepository: BasketAdminRepository())),
      ],
      child: GetMaterialApp(
        title: 'Haji Market',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            token != true ? const ViewAuthRegisterPage() : const Base(index: 1),
// const BaseAdmin()
        // const SelectCountryPage()
      ),
    );
  }
}
