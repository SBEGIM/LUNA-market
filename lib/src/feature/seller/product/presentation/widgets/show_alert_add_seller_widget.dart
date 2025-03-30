import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/seller/product/bloc/ad_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/bloc/product_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/edit_product_seller_page.dart';
import '../../../../../core/common/constants.dart';
import '../../../../basket/presentation/widgets/payment_webview_widget.dart';
import '../../data/models/product_seller_model.dart';

// Future<dynamic> showAlertAddWidget(BuildContext context, AdminProductsModel product) async {
//   int ad = -1;

//   bool load = false;

//   List<int> price = [556900, 1000900, 1500900];

//   return showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) => StatefulBuilder(builder: (context, setState) {
//             return CupertinoActionSheet(
//               actions: <Widget>[
//                 CupertinoActionSheetAction(
//                   child: const Text(
//                     'Выберите формат рекламы',
//                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
//                   ),
//                   onPressed: () {},
//                 ),
//                 CupertinoActionSheetAction(
//                   onPressed: () {},
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       const Text(
//                         '1000 просмотров / 556 900 руб',
//                         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ad = 0;
//                           setState(() {});

//                           //Navigator.pop(context, 'Cancel');
//                           // showAlertAddWidget(context, product);
//                         },
//                         child: Icon(
//                           ad == 0 ? Icons.check_box : Icons.check_box_outline_blank,
//                           color: AppColors.kPrimaryColor,
//                           size: 24.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 CupertinoActionSheetAction(
//                   onPressed: () {},
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       const Text(
//                         '3000 просмотров / 1000 900 руб',
//                         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ad = 1;
//                           setState(() {});
//                           // Navigator.pop(context, 'Cancel');
//                           // showAlertAddWidget(context, product);
//                         },
//                         child: Icon(
//                           ad == 1 ? Icons.check_box : Icons.check_box_outline_blank,
//                           color: AppColors.kPrimaryColor,
//                           size: 24.0,
//                           semanticLabel: 'Text to announce in accessibility modes',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 CupertinoActionSheetAction(
//                   onPressed: () {},
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       const Text(
//                         '5000 просмотров / 1500 900 руб',
//                         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           ad = 2;
//                           setState(() {});
//                           //   Navigator.pop(context, 'Cancel');
//                           // showAlertAddWidget(context, product);
//                         },
//                         child: Icon(
//                           ad == 2 ? Icons.check_box : Icons.check_box_outline_blank,
//                           color: AppColors.kPrimaryColor,
//                           size: 24.0,
//                           semanticLabel: 'Text to announce in accessibility modes',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 CupertinoActionSheetAction(
//                   onPressed: () async {
//                     load = true;
//                     setState(
//                       () {},
//                     );
//                     final data = await BlocProvider.of<ProductAdminCubit>(context).ad(product.id!, price[ad]);
//                     load = false;
//                     setState(
//                       () {},
//                     );
//                     Get.to(() => PaymentWebviewPage(
//                           url: data!,
//                           role: 'shop',
//                         ));
//                   },
//                   child: load == true
//                       ? const CircularProgressIndicator(
//                           color: Colors.blueAccent,
//                         )
//                       : Text(
//                           'Оплатить  ${ad != -1 ? ("${price[ad]} руб") : ''}',
//                           style: const TextStyle(
//                               color: AppColors.kPrimaryColor, fontWeight: FontWeight.w700, fontSize: 20),
//                         ),
//                 ),
//               ],
//               cancelButton: CupertinoActionSheetAction(
//                 child: const Text(
//                   'Отмена',
//                   style: TextStyle(color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context, 'Cancel');
//                 },
//               ),
//             );
//           }));
// }

class ShowAdTypesAlertSellerWidget extends StatefulWidget {
  final ProductSellerModel product;
  const ShowAdTypesAlertSellerWidget({super.key, required this.product});

  @override
  State<ShowAdTypesAlertSellerWidget> createState() =>
      _ShowAdTypesAlertSellerWidgetState();
}

class _ShowAdTypesAlertSellerWidgetState
    extends State<ShowAdTypesAlertSellerWidget> {
  int adPrice = -1;

  bool load = false;

  // List<int> price = [556900, 1000900, 1500900];
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Выберите формат рекламы',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          onPressed: () {},
        ),
        BlocBuilder<AdSellerCubit, AdSellerState>(
          builder: (context, state) {
            if (state is LoadedState) {
              return Column(
                children: state.ads
                    .map(
                      (e) => CupertinoActionSheetAction(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${e.viewCount} просмотров / ${e.price} руб',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (e.price != null) {
                                  adPrice = e.price!;
                                  setState(() {});
                                }

                                //Navigator.pop(context, 'Cancel');
                                // showAlertAddWidget(context, product);
                              },
                              child: Icon(
                                adPrice == e.price
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: AppColors.kPrimaryColor,
                                size: 24.0,
                              ),
                            ),
                          ],
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
        CupertinoActionSheetAction(
          onPressed: () async {
            load = true;
            setState(
              () {},
            );
            final data = await BlocProvider.of<ProductSellerCubit>(context)
                .ad(widget.product.id!, adPrice);

            load = false;
            setState(
              () {},
            );
            Get.to(() => PaymentWebviewPage(
                  url: data!,
                  role: 'shop',
                ));
          },
          child: load == true
              ? const CircularProgressIndicator(
                  color: Colors.blueAccent,
                )
              : Text(
                  'Оплатить  ${adPrice != -1 ? ("$adPrice руб") : ''}',
                  style: const TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Отмена',
          style: TextStyle(
              color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    );
  }
}
