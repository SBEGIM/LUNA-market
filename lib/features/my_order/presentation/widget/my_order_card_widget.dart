import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/my_order/presentation/widget/my_order_status_page.dart';


class MyOrderCardWidget extends StatefulWidget {

  final BasketOrderModel basketOrder;

  const MyOrderCardWidget({
    required this.basketOrder,
    Key? key
  }) : super(key: key);

  @override
  State<MyOrderCardWidget> createState() => _MyOrderCardWidgetState();
}

class _MyOrderCardWidgetState extends State<MyOrderCardWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
         Text(
          '${widget.basketOrder.date}',
          style: const TextStyle(
              color: AppColors.kGray300,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Доставка будет ${widget.basketOrder.returnDate}',
                style: const TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Image.network(
               "http://80.87.202.73:8001/storage/${widget.basketOrder.product!.first.path!.first.toString()}",
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                 'Заказ № ${widget.basketOrder.id}',
                style: const TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              const Divider(
                color: AppColors.kGray300,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyOrderStatusPage(basketOrder: widget.basketOrder)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                  const  Text(
                      'Детали заказа',
                      style: TextStyle(
                        fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kPrimaryColor),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 11.75),
                      height: 16.5,
                      width: 9.5,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kPrimaryColor,
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
