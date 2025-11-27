import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/products_card_widget.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart';
import 'package:haji_market/src/feature/product/cubit/product_state.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final _box = GetStorage();

  @override
  void initState() {
    final filters = context.read<FilterProvider>();

    BlocProvider.of<ProductCubit>(context).products(filters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
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
            child: Padding(
              padding: EdgeInsets.only(top: 200.0),
              child: Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
            ),
          );
        }

        if (state is LoadedState) {
          return SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: NotificationListener<UserScrollNotification>(
              onNotification: (n) {
                // В самом верху — показываем товары
                if (n.metrics.pixels <= n.metrics.minScrollExtent + 0.5) {
                  _box.write('scrollView', false);
                  return false;
                }

                // Тянем вверх (контент едет ВВЕРХ) — прячем товары
                if (n.direction == ScrollDirection.reverse) {
                  _box.write('scrollView', true);
                }
                // Тянем вниз (контент едет ВНИЗ) — показываем товары
                else if (n.direction == ScrollDirection.forward) {
                  _box.write('scrollView', false);
                }
                return false;
              },
              child: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 173 / 315,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return InkWell(
                    onTap: () {
                      context.router.push(
                        DetailCardProductRoute(product: state.productModel[index]),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: ProductCardWidget(product: state.productModel[index], index: index),
                  );
                }, childCount: state.productModel.length),
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 200.0),
              child: Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
            ),
          );
        }
      },
    );
  }
}
