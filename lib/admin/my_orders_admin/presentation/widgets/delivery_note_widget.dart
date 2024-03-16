import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/basket_admin_order_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DeliveryNoteAdmin extends StatefulWidget {
  final BasketAdminOrderModel basketOrder;

  const DeliveryNoteAdmin({required this.basketOrder, super.key});

  @override
  State<DeliveryNoteAdmin> createState() => _DeliveryNoteAdminState();
}

class _DeliveryNoteAdminState extends State<DeliveryNoteAdmin> {
  String address = "";

  @override
  void initState() {
    // TODO: implement initState
    addresses();
    super.initState();
  }

  addresses() {
    String? street = widget.basketOrder.user!.street;
    String? home = widget.basketOrder.user!.home;
    String? porch = widget.basketOrder.user!.porch;
    String? floor = widget.basketOrder.user!.floor;
    String? room = widget.basketOrder.user!.room;

    address = 'ул. ${street ?? '*'}, дом ${home ?? '*'},подъезд ${porch ?? '*'},этаж ${floor ?? '*'},кв ${room ?? '*'}';
  }

  ScreenshotController screenshotController = ScreenshotController();

  final int _counter = 0;
  Uint8List? _imageFile;
  XFile? imageF;

  Future<void> imageFile() async {
    screenshotController.capture().then((Uint8List? uint8list) async {
      // //Capture Done
      // setState(() {
      //   _imageFile = image;
      // });
      if (uint8list != null) {
        //  File tempFile = File.fromRawPath(uint8list);
        //  XFile xfile = XFile(path)

        Uint8List imageInUnit8List = uint8list; // stor§e unit8List image here ;
        final tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}/image.png').create();
        file.writeAsBytesSync(imageInUnit8List);
        XFile xfile = XFile(file.path, bytes: uint8list);

        await Share.shareXFiles(
          [xfile],
        );
      }
    }).catchError((onError) {
      print(onError);
      Get.snackbar('Ошибка', '', backgroundColor: Colors.redAccent);
    });
  }

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
        body: Screenshot(
          controller: screenshotController,
          child: ListView(children: [
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/appIcon.png',
                            height: 70,
                            width: 70,
                          ),
                          Container(
                              height: 100,
                              width: 100,
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: QrImageView(
                                semanticsLabel: '${widget.basketOrder.id}',
                                data: '${widget.basketOrder.id}',
                              )),
                          const SizedBox(
                            width: 30,
                          ),
                          // Container(
                          //   height: 110,
                          //   width: 110,
                          //   padding: const EdgeInsets.all(8.0),
                          //   alignment: Alignment.centerLeft,
                          //   child: QrImage(
                          //     data: "${widget.basketOrder.id}",
                          //     version: QrVersions.auto,
                          //   ),
                          // ),
                          // // Image.asset(
                          //   'assets/images/code.png',
                          //   height: 120,
                          //   width: 120,
                          // ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          imageFile();
                        },
                        child: const Icon(Icons.share, color: AppColors.kPrimaryColor, size: 24),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),

                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Откуда',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${widget.basketOrder.product!.first.shopName}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 150,
                              height: 100,
                              child: Text(
                                '${widget.basketOrder.product!.first.address}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Отправитель',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.basketOrder.product?.first.shopName ?? 'Неизвестно',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Номер отправителя',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.basketOrder.product?.first.shopPhone ?? 'Неизвестно',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Вес посылки',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Дата доставки',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: widget.basketOrder.product!.length * 40,
                              width: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.basketOrder.product!.length,
                                shrinkWrap: false,
                                itemBuilder: (context, index) {
                                  return Text(
                                    '${widget.basketOrder.product![0].productName}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Куда',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${GetStorage().read('city')}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 150,
                              height: 100,
                              child: Text(
                                address,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Получатель',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.basketOrder.user?.name ?? 'Неизвестно',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Номер получателя',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.basketOrder.user?.phone.toString() ?? 'Неизвестно',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              ' ${(widget.basketOrder.product!.first.count! * 1.4).round()} кг',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${widget.basketOrder.returnDate}',
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: widget.basketOrder.product!.length * 35,
                              width: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.basketOrder.product!.length,
                                shrinkWrap: false,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      const SizedBox(height: 15),
                                      Text(
                                        '${widget.basketOrder.product![0].count} шт',
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  // const Text(
                  //   'Посылка',
                  //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                  // ),
                  // const Text(
                  //   'Дополнительные комментарий',
                  //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                  // ),
                  const SizedBox(height: 12),
                  const TextField(
                    // controller: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Напишите комментарий',
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(194, 197, 200, 1), fontSize: 16, fontWeight: FontWeight.w400),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 12),
                  // Text(
                  //   '${widget.basketOrder.comment ?? 'Нет комментарий'}',
                  //   style: const TextStyle(
                  //       fontSize: 16, fontWeight: FontWeight.w400),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Container(
            //     height: 164,
            //     width: 168,
            //     padding: const EdgeInsets.all(8.0),
            //     alignment: Alignment.centerLeft,
            //     child: QrImageView(
            //       semanticsLabel: '${widget.basketOrder.id}',
            //       data: '',
            //     )),
          ]),
        ));
  }
}
