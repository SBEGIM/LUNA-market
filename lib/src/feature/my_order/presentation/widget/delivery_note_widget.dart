import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
// import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../basket/data/models/basket_order_model.dart';

class DeliveryNote extends StatefulWidget {
  final BasketOrderModel basketOrder;

  const DeliveryNote({required this.basketOrder, super.key});

  @override
  State<DeliveryNote> createState() => _DeliveryNoteState();
}

class _DeliveryNoteState extends State<DeliveryNote> {
  String address =
      "${'ул. ' + (GetStorage().read('street') ?? '*') + ', дом ' + (GetStorage().read('home') ?? '*') + ',подъезд ' + (GetStorage().read('porch') ?? '*') + ',этаж ' + (GetStorage().read('floor') ?? '*') + ',кв ' + (GetStorage().read('room') ?? '*')}";

  // ScreenshotController screenshotController = ScreenshotController();

  int _counter = 0;
  Uint8List? _imageFile;
  XFile? imageF;

  // Future<void> imageFile() async {
  //   screenshotController.capture().then((Uint8List? uint8list) async {
  //     // //Capture Done
  //     // setState(() {
  //     //   _imageFile = image;
  //     // });
  //     if (uint8list != null) {
  //       //  File tempFile = File.fromRawPath(uint8list);
  //       //  XFile xfile = XFile(path)

  //       Uint8List imageInUnit8List = uint8list; // stor§e unit8List image here ;
  //       final tempDir = await getTemporaryDirectory();
  //       File file = await File('${tempDir.path}/image.png').create();
  //       file.writeAsBytesSync(imageInUnit8List);
  //       XFile xfile = XFile(file.path, bytes: uint8list);

  //       await Share.shareXFiles(
  //         [xfile],
  //       );
  //     }
  //   }).catchError((onError) {
  //     print(onError);
  //     Get.snackbar('Ошибка', 'sss');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Накладная',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SizedBox(),
    );
  }
  //       body: Screenshot(
  //         controller: screenshotController,
  //         child: ListView(children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Image.asset(
  //                           'assets/images/appIcon.png',
  //                           height: 70,
  //                           width: 70,
  //                         ),
  //                         const SizedBox(
  //                           width: 30,
  //                         ),
  //                         Image.asset(
  //                           'assets/images/code.png',
  //                           height: 120,
  //                           width: 120,
  //                         ),
  //                       ],
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         imageFile();
  //                       },
  //                       child: const Icon(Icons.share,
  //                           color: AppColors.kPrimaryColor, size: 24),
  //                     )
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: const [
  //                     Text(
  //                       'Откуда',
  //                       style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w400,
  //                           color: Colors.grey),
  //                     ),
  //                     Text(
  //                       'Куда',
  //                       style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w400,
  //                           color: Colors.grey),
  //                     )
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       '${widget.basketOrder.product!.first.shopCityName}',
  //                       style: const TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.w400),
  //                     ),
  //                     Text(
  //                       '${GetStorage().read('city')}',
  //                       style: const TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.w400),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     SizedBox(
  //                       width: 180,
  //                       child: Text(
  //                         '${widget.basketOrder.product!.first.address}',
  //                         style: const TextStyle(
  //                             fontSize: 16, fontWeight: FontWeight.w400),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                         width: 180,
  //                         child: Text(
  //                           '${address}',
  //                           style: const TextStyle(
  //                               fontSize: 16, fontWeight: FontWeight.w400),
  //                         )),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: const [
  //                     Text(
  //                       'Отправитель',
  //                       style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w400,
  //                           color: Colors.grey),
  //                     ),
  //                     Text(
  //                       'Получатель',
  //                       style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w400,
  //                           color: Colors.grey),
  //                     )
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       '${widget.basketOrder.product!.first.shopName}',
  //                       style: const TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.w400),
  //                     ),
  //                     Text(
  //                       '${GetStorage().read('name')}',
  //                       style: const TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.w400),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: const [
  //                     Text(
  //                       'Номер отправителя',
  //                       style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w400,
  //                           color: Colors.grey),
  //                     ),
  //                     Text(
  //                       'Номер получателя',
  //                       style: TextStyle(
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.w400,
  //                           color: Colors.grey),
  //                     )
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       '${widget.basketOrder.product!.first.shopPhone}',
  //                       style: const TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.w400),
  //                     ),
  //                     Text(
  //                       '${GetStorage().read('phone')}',
  //                       style: const TextStyle(
  //                           fontSize: 16, fontWeight: FontWeight.w400),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 const Text(
  //                   'Дата доставки',
  //                   style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w400,
  //                       color: Colors.grey),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   '${widget.basketOrder.returnDate}',
  //                 ),
  //                 const SizedBox(height: 12),
  //                 const Text(
  //                   'Посылка',
  //                   style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w400,
  //                       color: Colors.grey),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 SizedBox(
  //                   height: widget.basketOrder.product!.length * 30,
  //                   child: ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     itemCount: widget.basketOrder.product!.length,
  //                     shrinkWrap: false,
  //                     itemBuilder: (context, index) {
  //                       return Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             '${widget.basketOrder.product![index].productName}',
  //                             style: const TextStyle(
  //                                 fontSize: 16, fontWeight: FontWeight.w400),
  //                           ),
  //                           Text(
  //                             '${widget.basketOrder.product![index].count} шт',
  //                             style: const TextStyle(
  //                                 fontSize: 16, fontWeight: FontWeight.w400),
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 const Text(
  //                   'Вес посылки',
  //                   style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w400,
  //                       color: Colors.grey),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   ' ${(widget.basketOrder.product!.first.count! * 1.4).toInt()} кг',
  //                   style: const TextStyle(
  //                       fontSize: 16, fontWeight: FontWeight.w400),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 const Text(
  //                   'Дополнительные комментарий',
  //                   style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w400,
  //                       color: Colors.grey),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 Text(
  //                   '${widget.basketOrder.comment ?? 'Нет комментарий'}',
  //                   style: const TextStyle(
  //                       fontSize: 16, fontWeight: FontWeight.w400),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           Container(
  //             padding: const EdgeInsets.all(8.0),
  //             alignment: Alignment.centerLeft,
  //             child: Image.asset(
  //               'assets/images/qr.png',
  //               height: 144,
  //               width: 148,
  //             ),
  //           ),
  //         ]),
  //       ));
  // }
}
