import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/payment_webview_widget.dart';
import 'package:haji_market/src/feature/seller/product/bloc/ad_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/models/product_seller_model.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showAdsOptions(BuildContext context, ProductSellerModel product) {
  showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => BlocProvider<AdSellerCubit>(
            create: (_) => AdSellerCubit(repository: ProductSellerRepository())
              ..getAdsList(),
            child: AdsOptionsModal(product: product),
          ));
}

class AdsOptionsModal extends StatefulWidget {
  final ProductSellerModel product;

  const AdsOptionsModal({Key? key, required this.product}) : super(key: key);

  @override
  _AdsOptionsModalState createState() => _AdsOptionsModalState();
}

class _AdsOptionsModalState extends State<AdsOptionsModal> {
  int adPrice = -1;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Заголовок
            ListTile(
              title: Text(
                'Выберите формат рекламы',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              onTap: () {},
            ),

            // Блок с объявлениями
            BlocBuilder<AdSellerCubit, AdSellerState>(
              builder: (context, state) {
                if (state is LoadedState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: state.ads
                        .map(
                          (e) => ListTile(
                            title: Text(
                              '${e.viewCount} просмотров / ${e.price} руб',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (e.price != null) {
                                  adPrice = e.price!;
                                }
                              });
                            },
                            trailing: Icon(
                              adPrice == e.price
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: adPrice == e.price
                                  ? Colors.blueAccent
                                  : Colors.blueAccent,
                              size: 28.0,
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),

            // Кнопка для оплаты
            ListTile(
              onTap: () async {
                setState(() {
                  load = true;
                });

                final data = await BlocProvider.of<AdSellerCubit>(context)
                    .ad(widget.product.id!, adPrice);

                setState(() {
                  load = false;
                });

                if (data != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentWebviewPage(
                        url: data,
                        role: 'shop',
                      ),
                    ),
                  );
                }
              },
              title: load
                  ? const CircularProgressIndicator(
                      color: Colors.blueAccent,
                    )
                  : Text(
                      'Оплатить  ${adPrice != -1 ? "$adPrice руб" : ''}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
            ),

            // Кнопка отмены
            ListTile(
              title: Text(
                'Отмена',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
