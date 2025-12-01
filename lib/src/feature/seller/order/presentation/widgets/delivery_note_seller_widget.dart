import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/order/data/models/basket_order_seller_model.dart';

class DeliveryNoteSellerPage extends StatefulWidget {
  final BasketOrderSellerModel basketOrder;

  const DeliveryNoteSellerPage({required this.basketOrder, super.key});

  @override
  State<DeliveryNoteSellerPage> createState() => _DeliveryNoteSellerPageState();
}

class _DeliveryNoteSellerPageState extends State<DeliveryNoteSellerPage> {
  String address = "";

  @override
  void initState() {
    addresses();
    super.initState();
  }

  void addresses() {
    String? street = widget.basketOrder.user!.street;
    String? home = widget.basketOrder.user!.apartament;
    String? porch = widget.basketOrder.user!.entrance;
    String? floor = widget.basketOrder.user!.floor;
    String? room = widget.basketOrder.user!.intercom;

    address =
        'ул. ${street ?? '*'}, дом ${home ?? '*'},подъезд ${porch ?? '*'},этаж ${floor ?? '*'},кв ${room ?? '*'}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        elevation: 0,
        centerTitle: true,
        title: const Text('Накладная', style: TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: SizedBox(),
    );
  }
}
