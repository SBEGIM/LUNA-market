import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

import '../../../product/data/model/product_model.dart';

class SpecificationsPage extends StatefulWidget {
  final ProductModel product;

  const SpecificationsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<SpecificationsPage> createState() => _SpecificationsPageState();
}

class _SpecificationsPageState extends State<SpecificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: AppColors.kPrimaryColor),
        ),
        title: const Text(
          'Характеристики',
          style: TextStyle(color: AppColors.kGray900, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Основные характеристики',
                  style: TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: (widget.product.characteristics?.length ?? 0) * 20,
                  child: ListView.builder(
                    itemCount: widget.product.characteristics?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: Text(
                              '${widget.product.characteristics![index].name}',
                              style: const TextStyle(
                                color: AppColors.kGray400,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          Text(
                            '${widget.product.characteristics![index].value}',
                            style: const TextStyle(
                              color: AppColors.kGray1000,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
