import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Рекламировать',
                    style: AppTextStyles.defaultButtonTextStyle,
                  ),
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close))
                ],
              ),
            ),
            // Блок с объявлениями
            BlocBuilder<AdSellerCubit, AdSellerState>(
              builder: (context, state) {
                if (state is LoadedState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: state.ads
                        .map(
                          (e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                minLeadingWidth: 0,
                                minTileHeight: 0,
                                title: Text(
                                  '${e.viewCount} просмотров',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
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
                                contentPadding: EdgeInsets.only(
                                    left: 12, right: 12, top: 0, bottom: 0),
                                trailing: Icon(
                                  adPrice == e.price
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: adPrice == e.price
                                      ? AppColors.mainPurpleColor
                                      : AppColors.kGray200,
                                  size: 28.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  ' ${e.price} ₽',
                                  textAlign: TextAlign.left,
                                  style: AppTextStyles.catalogTextStyle
                                      .copyWith(color: AppColors.kGray300),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              )
                            ],
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

            SizedBox(height: 12),
            // Кнопка для оплаты
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 20),
              decoration: BoxDecoration(
                  color: AppColors.mainPurpleColor,
                  borderRadius: BorderRadius.circular(16)),
              child: ListTile(
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
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
