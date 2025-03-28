import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/products_card_widget.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart';
import 'package:haji_market/src/feature/product/cubit/product_state.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).products();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ErrorState) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
              ),
            );
          }
          if (state is LoadingState) {
            return const SliverToBoxAdapter(
              child: Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent)),
            );
          }

          if (state is LoadedState) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels ==
                    notification.metrics.minScrollExtent) {
                  Future.delayed(const Duration(milliseconds: 100), () {})
                      .then((s) {
                    GetStorage().write('scrollView', false);
                  });

                  // GetStorage().write('scrollView', false);
                } else if (notification.direction == ScrollDirection.reverse) {
                  Future.delayed(const Duration(milliseconds: 200), () {})
                      .then((s) {
                    GetStorage().write('scrollView', true);
                  });
                }
                return true;
              },
              child: SliverList.builder(
                itemCount: state.productModel.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.router.push(
                        DetailCardProductRoute(
                          product: state.productModel[index],
                        ),
                      );
                    },
                    child: ProductCardWidget(
                      product: state.productModel[index],
                      index: index,
                    ),
                  );
                },
              ),
            );
          } else {
            return const SliverToBoxAdapter(
              child: Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent)),
            );
          }
        });
  }
}
