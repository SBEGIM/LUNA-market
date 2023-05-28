import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

class ProductImages extends StatefulWidget {
  List<String> images;
  ProductImages({required this.images, super.key});

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
            height: 343,
            width: 378,
            child: Image.network(
              "http://185.116.193.73/storage/${widget.images[imageIndex]}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 82, left: 16, right: 16),
            height: 80,
            // width: 80,
            // color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (() {
                    imageIndex = index;
                    setState(() {});
                  }),
                  child: Container(
                    margin: const EdgeInsets.only(top: 24, left: 8),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 0.3,
                          color: imageIndex == index
                              ? AppColors.kPrimaryColor
                              : Colors.grey),
                    ),
                    //color: Colors.red,
                    child: Image.network(
                      "http://185.116.193.73/storage/${widget.images[index]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
