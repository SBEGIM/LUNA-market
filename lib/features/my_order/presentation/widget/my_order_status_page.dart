import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/my_order/presentation/widget/cancel_order_widget.dart';
import 'package:haji_market/features/my_order/presentation/widget/delivery_note_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../chat/presentation/chat_page.dart';
import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/review_cubit.dart';

class MyOrderStatusPage extends StatefulWidget {
  final BasketOrderModel basketOrder;

  const MyOrderStatusPage({required this.basketOrder, Key? key})
      : super(key: key);

  @override
  State<MyOrderStatusPage> createState() => _MyOrderStatusPageState();
}

class _MyOrderStatusPageState extends State<MyOrderStatusPage> {
  bool inbasket = false;
  bool hidden = false;
  String productId = '';
  String productName = '';

  int rating = 0;

  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '№ ${widget.basketOrder.id}',
            style: const TextStyle(color: Colors.black, fontSize: 16),
          )),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${widget.basketOrder.date}',
                  style: const TextStyle(
                      color: AppColors.kGray300,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Оплачен',
                        style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TimelineTile(
                        isFirst: true,
                        indicatorStyle: IndicatorStyle(
                          color: AppColors.kPrimaryColor,
                          iconStyle: IconStyle(
                            color: Colors.white,
                            iconData: Icons.check,
                          ),
                        ),
                        beforeLineStyle: const LineStyle(
                          thickness: 1.4,
                        ),
                        lineXY: 0.4,
                        endChild: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Заказ оплачен',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${widget.basketOrder.date}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.kGray300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TimelineTile(
                        isLast: true,
                        indicatorStyle: IndicatorStyle(
                          color: Colors.grey,
                          iconStyle: IconStyle(
                            color: Colors.grey,
                            iconData: Icons.start,
                          ),
                        ),
                        beforeLineStyle: const LineStyle(
                          thickness: 1.4,
                        ),
                        lineXY: 0.4,
                        endChild: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.basketOrder.status == 'cancel' ? 'Отменен' : 'Доставка'}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${widget.basketOrder.status == 'cancel' ? widget.basketOrder.updated_at : widget.basketOrder.returnDate}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.kGray300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 1,
                        color: AppColors.kGray500,
                      ),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CancelOrderWidget(
                                          id: widget.basketOrder.id
                                              .toString())),
                                );
                              },
                              child: Container(
                                height: 38,
                                width: 136,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Отменить',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                // setState(() {});

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const QRViewExample(),
                                ));
                              },
                              child: Container(
                                height: 38,
                                width: 136,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(29, 196, 207, 0.4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Возврат',
                                  style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Продовец',
                          style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 54,
                              width: 54,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(34),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "http://185.116.193.73/storage/shops/1.png"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(width: 13),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.basketOrder.product!.first.shopName}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '+7${widget.basketOrder.product!.first.shopPhone}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.off(ChatPage);
                                // GetStorage()
                                //     .write('video_stop', true);
                                Get.to(() => const ChatPage());
                                // Get.to(ProductsPage(
                                //   cats: Cats(id: 0, name: ''),
                                // ));
                                // GetStorage()
                                //     .write('shopFilterId', 1);
                              },
                              child: Container(
                                height: 30,
                                width: 108,
                                decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Написать',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Адрес доставки',
                          style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location.svg',
                            ),
                            const SizedBox(width: 13),
                            Text(
                              '${widget.basketOrder.product?.first.address ?? 'Неизвестен'}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                color: Colors.white,
                height: widget.basketOrder.product!.length * 180,
                // width: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.basketOrder.product!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 170,
                        // width: 100,
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 12),
                        color: Colors.white,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              "http://185.116.193.73/storage/${widget.basketOrder.product![index].path!.first.toString()}",
                              width: 120,
                              height: 120,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 185,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${widget.basketOrder.product![index].price} ₽',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${widget.basketOrder.product![index].count} шт',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${widget.basketOrder.product![index].productName}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 18),
                                GestureDetector(
                                  onTap: () async {
                                    if (inbasket != true) {
                                      await BlocProvider.of<BasketCubit>(
                                              context)
                                          .basketAdd(
                                              widget.basketOrder.product![index]
                                                  .id,
                                              '1');
                                      Get.snackbar(
                                          'Успешно', 'Товар добавлен в корзину',
                                          backgroundColor: Colors.blueAccent);

                                      inbasket = true;
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    height: 38,
                                    width: 136,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      inbasket != true
                                          ? 'В корзину'
                                          : 'Добавлен в корзину',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (widget.basketOrder.status == 'end')
                                  GestureDetector(
                                    onTap: () {
                                      productId = widget
                                          .basketOrder.product![index].id
                                          .toString();

                                      productName = widget.basketOrder
                                          .product![index].productName
                                          .toString();
                                      hidden = !hidden;

                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 38,
                                      width: 136,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            29, 196, 207, 0.4),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Оставить отзыв',
                                        style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                              ],
                            )
                          ],
                        ));
                  },
                ),
              ),
              Visibility(
                visible: hidden,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Оставьте отзыв',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start,
                            ),
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              itemSize: 15,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {
                                rating = value.toInt();
                              },
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _commentController,
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Напишите отзывь для ${productName}',
                              border: InputBorder.none),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await BlocProvider.of<ReviewCubit>(context)
                                .reviewStore(_commentController.text,
                                    rating.toString(), productId);
                            _commentController.clear();

                            hidden = !hidden;

                            setState(() {});

                            Get.snackbar('Успешно', 'отзыв добавлен',
                                backgroundColor: Colors.blueAccent);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 39,
                            width: 209,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(width: 0.2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(
                                    0.2,
                                    0.2,
                                  ), //Offset
                                  blurRadius: 0.1,
                                  spreadRadius: 0.1,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: const Text(
                              'Оставить свой отзыв',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 55,
                      child: ListTile(
                        title: const Text(
                          'Товар',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          '${widget.basketOrder.product!.first.productName}',
                          style: const TextStyle(
                              color: AppColors.kGray300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Text(
                          '${widget.basketOrder.summa} ₽ ',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: const Text('Доставка'),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              '${widget.basketOrder.product!.first.shopCourier!.toInt()} ₽ ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: const Text(
                              'К оплате',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              '${widget.basketOrder.summa!.toInt() + widget.basketOrder.product!.first.shopCourier!.toInt()} ₽ ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    // const Divider(
                    //   color: AppColors.kGray400,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.to(DeliveryNote(basketOrder: widget.basketOrder));
                    //   },
                    //   child: SizedBox(
                    //     height: 35,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Container(
                    //           alignment: Alignment.center,
                    //           padding: const EdgeInsets.only(left: 16),
                    //           child: const Text(
                    //             'Скачать накладную',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w500,
                    //               color: AppColors.kPrimaryColor,
                    //             ),
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           width: 5,
                    //         ),
                    //         const Icon(
                    //           Icons.download,
                    //           color: AppColors.kPrimaryColor,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Формат: ${describeEnum(result!.format)}   Результат: ${result!.code}')
                  else
                    const Text('Сканирование...'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text(
                                    'Свет: ${snapshot.data != false ? 'включен' : 'выключен'}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Камера: ${describeEnum(snapshot.data!) != 'back' ? 'передняя' : 'задняя'}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('Пауза',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('Продолжать',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
