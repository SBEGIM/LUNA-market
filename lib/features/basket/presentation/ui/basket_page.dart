import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';
import 'package:haji_market/features/basket/presentation/ui/interesting_product_widget.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';

import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/basket_state.dart';
import '../../../home/presentation/widgets/banner_watceh_recently_widget.dart';
import '../../data/DTO/basketOrderDto.dart';
import 'basket_order_page.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {

  int count = 0;
  int price = 0;

  List<BasketShowModel>? basket = [];

Future<void> basketData()async{
       basket = await BlocProvider.of<BasketCubit>(context).basketData() ;
       basket!.forEach((element) {
          count += element.basketCount!.toInt();
          price += element.price!.toInt();
        });
      setState(() {
      });
}


  @override
  void initState() {
    BlocProvider.of<BasketCubit>(context).basketShow();
    basketData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: SvgPicture.asset('assets/icons/share.svg'))
          ],
          title:Container(
            padding:const EdgeInsets.only(left: 100),
            child: const Text(
              'Корзина',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          )),
      body: BlocConsumer<BasketCubit,BasketState>(
        listener: (context, state) {},

        builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is LoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent)
            );
          }

          if (state is LoadedState) {
            return ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.basketShowModel.length,
                    // separatorBuilder: (BuildContext context, int index) =>
                    //     const Divider(),
                    itemBuilder: (BuildContext context, int index) {

                      return  BasketProductCardWidget(
                          basketProducts: state.basketShowModel[index],
                          count: index,

                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Вас могут заинтересовать',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          // InterestingProductWidget(),
                          InterestingProductWidget(),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                )
              ],
            );
          }else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent)
            );
          }
        }),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 26, bottom: 26),
        child: InkWell(
          onTap: () {
            Get.to( BasketOrderPage());
            // Navigator.pop(context);
          },
          child: Container(
            height: 75,
            child:   Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('В корзине: ${count} товара'),
                  Text('Всего: ${price}'),
                ],),
                SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.kPrimaryColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Продолжить',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
              ],
            )
          )
        ),
      ),
    );
  }
}

class BasketProductCardWidget extends StatefulWidget {
  final BasketShowModel basketProducts;
  final int count;
  const BasketProductCardWidget({
    required this.count,
    required this.basketProducts,
    Key? key,
  }) : super(key: key);

  @override
  State<BasketProductCardWidget> createState() =>
      _BasketProductCardWidgetState();
}

class _BasketProductCardWidgetState extends State<BasketProductCardWidget> {

  int basketCount = 0;
  int basketPrice = 0;
  bool isVisible = true;

  List<basketOrderDTO> basketOrder = [];

  @override
  void initState() {

    basketCount = widget.basketProducts.basketCount!.toInt();
    basketPrice = widget.basketProducts.price!.toInt();

    // basketOrder[widget.count] = basketOrderDTO(product: ProductDTO(
    //   id: widget.basketProducts.product!.id!.toInt(),
    //   courier_price: widget.basketProducts.product!.courierPrice!.toInt(),
    //   compound: widget.basketProducts.product!.compound!.toInt(),
    //   shop_id: widget.basketProducts.product!.shopId!.toInt(),
    //   price: widget.basketProducts.product!.price!.toInt(),
    //   name: widget.basketProducts.product!.name.toString(),
    // ), basket: BasketDTO(
    //   basket_id: widget.basketProducts.basketId!.toInt(),
    //   price_courier: widget.basketProducts.priceCourier!.toInt(),
    //   price: widget.basketProducts.price!.toInt(),
    //   basket_count: widget.basketProducts.basketCount!.toInt(),
    //   basket_color: widget.basketProducts.basketColor.toString(),
    //   basket_size: widget.basketProducts.basketSize.toString(),
    //   shop_name: widget.basketProducts.shopName.toString(),
    //   address: [],
    // ));

   // basketOrder[widget.count] = basketOrderDTO(product: null, basket:  null);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return  Visibility(
        visible: isVisible,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 4, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 2),
                      // blurRadius: 4,
                      color: Colors.white,
                    ),
                  ]),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            // blurRadius: 4,
                            color: Colors.white,
                          ),
                        ]),
                    // height: MediaQuery.of(context).size.height * 0.86,
                    // color: Colors.red,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 100,
                              width: 158,
                              decoration: BoxDecoration(
                                  image:  DecorationImage(
                                    image: NetworkImage("http://80.87.202.73:8001/storage/${widget.basketProducts.image!.first}"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children:  [
                                  Text(
                                    '${ (widget.basketProducts.product!.price!.toInt()  - widget.basketProducts.product!.compound!.toInt())} ₸ ',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '${widget.basketProducts.product!.price} ₸ ',
                                    style: const TextStyle(
                                      color: AppColors.kGray900,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '$basketPrice ₸/$basketCount шт',
                                style: const TextStyle(
                                  color: AppColors.kGray300,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${widget.basketProducts.product!.name}',
                                style:  const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.kGray900,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Продавец: ${widget.basketProducts.shopName}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.kGray900,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Доставка: неизвестно',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.kGray900,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap:() {
                              BlocProvider.of<BasketCubit>(context).basketMinus(widget.basketProducts.product!.id.toString(), '1');

                              basketCount-- ;
                              basketPrice = (basketPrice - (widget.basketProducts.product!.price!.toInt() - widget.basketProducts.product!.compound!.toInt()));
                              if(basketCount == 0){
                                isVisible = false;
                              }

                              setState(() {
                              });
                            },
                            child:  Container(
                              height: 32,
                              width: 32,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: basketCount == 0 ?  SvgPicture.asset('assets/icons/basket_1.svg' ) :
                              Text('―' , style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kPrimaryColor,
                              ),
                                textAlign: TextAlign.center,

                              )
                              ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(basketCount.toString()),
                          const SizedBox(
                            width: 14,
                          ),
                          GestureDetector(
                            onTap:(){
                              BlocProvider.of<BasketCubit>(context).basketAdd(widget.basketProducts.product!.id.toString(), '1');
                              setState(() {
                                basketCount++ ;
                                basketPrice = (basketPrice + (widget.basketProducts.product!.price!.toInt() - widget.basketProducts.product!.compound!.toInt()));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                          )
                        ],
                      ),

                      GestureDetector(
                        onTap: (){
                          BlocProvider.of<BasketCubit>(context).basketMinus(widget.basketProducts.product!.id.toString(), basketCount.toString());
                          isVisible = false;

                          setState(() {
                          });
                        },
                        child: const Text(
                          'Удалить',
                          style:  TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Выберите карту, чтобы поделиться'),
                Checkbox(
                  checkColor: Colors.white,
                  // fillColor: MaterialStateProperty.resolveWith(Colors.),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            )
          ],
        )
    );


  }

  bool isChecked = false;
}
