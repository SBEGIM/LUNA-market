import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/admin/my_products_admin/data/DTO/size_count_dto.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/color_cubit.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/size_cubit.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/brands_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/colors_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/sub_caats_admin_page.dart';
import 'package:haji_market/blogger_ad.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../../features/home/data/model/Cats.dart';
import '../../../admin_app/presentation/base_admin.dart';
import '../../data/DTO/color_count_dto.dart';
import '../../data/DTO/optom_price_dto.dart';
import '../../data/bloc/product_admin_cubit.dart';
import '../../data/bloc/product_admin_state.dart';
import 'cats_admin_page.dart';

class CreateProductPage extends StatefulWidget {
  final Cats cat;
  final Cats subCat;
  const CreateProductPage({required this.cat, required this.subCat, Key? key})
      : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  Cats? cats;
  Cats? subCats;
  Cats? brands;
  Cats? colors;

  TextEditingController articulController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController compoundController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController massaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController colorCountController = TextEditingController();
  TextEditingController sizeCountController = TextEditingController();
  TextEditingController sizePriceController = TextEditingController();
  TextEditingController optomPriceController = TextEditingController();
  TextEditingController optomCountController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  TextEditingController pointsBloggerController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController deepController = TextEditingController();

  List<XFile?> _image = [];
  XFile? _video;

  final ImagePicker _picker = ImagePicker();

  bool change = false;

  String colorName = '';

  String sizeName = '';
  String sizeId = '';
  String currencyName = 'Выберите валюту';

  List<colorCountDto> colorCount = [];
  List<Cats>? mockSizeAdds = [];
  List<optomPriceDto> optomCount = [];
  List<sizeCountDto> sizeCount = [];
  List<Cats>? mockSizes = [];

  bool isSwitched = false;
  bool isSwitchedBs = false;
  bool isChangeState = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  void toggleSwitchBs(bool value) {
    if (isSwitchedBs == false) {
      setState(() {
        isSwitchedBs = true;
      });
    } else {
      setState(() {
        isSwitchedBs = false;
      });
    }
  }

  Future<void> _getImage() async {
    final image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(image);
    });
  }

  Future<void> _getVideo() async {
    final video = change == true
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = video;
    });
  }

  void _sizeArray() async {
    mockSizes = await BlocProvider.of<SizeCubit>(context).sizes();
  }

  @override
  void initState() {
    cats = widget.cat;
    subCats = widget.subCat;
    brands = Cats(id: 0, name: 'Выберите бренд');
    colors = Cats(id: 0, name: 'Выберите цвет');
    _sizeArray();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Создать  новый товар',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: BlocConsumer<ProductAdminCubit, ProductAdminState>(
          listener: (context, state) {
        if (state is ChangeState && isChangeState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BaseAdmin()),
          );
          isChangeState = false;
        }
      }, builder: (context, state) {
        if (state is LoadedState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                FieldsProductRequest(
                  titleText: 'Артикул ',
                  hintText: 'Введите артикул  ',
                  star: false,
                  arrow: false,
                  controller: articulController,
                  textInputNumber: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Валюта',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.kGray900),
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.red),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: TextField(
                            // controller: ,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: currencyName,
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(194, 197, 200, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                                // suffixIcon: IconButton(
                                //   onPressed: widget.onPressed,
                                //   icon: widget.arrow == true
                                //       ? SvgPicture.asset('assets/icons/back_menu.svg',
                                //           color: Colors.grey)
                                //       : SvgPicture.asset(''),
                                // ),
                                suffixIcon: PopupMenuButton(
                                  onSelected: (value) {
                                    currencyName = value;

                                    setState(() {});

                                    // mockSizeAdds!.forEach((element) {
                                    //   return print(element.name);
                                    // });
                                  },
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  icon: SvgPicture.asset(
                                      'assets/icons/dropdown.svg'),
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 0),
                                  itemBuilder: (
                                    BuildContext bc,
                                  ) {
                                    return const [
                                      PopupMenuItem(
                                        value: 'KZT',
                                        child: Text(
                                          'KZT',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'RUB',
                                        child: Text(
                                          'RUB',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FieldsProductRequest(
                    titleText: 'Цена товара ',
                    hintText: 'Введите цену  ',
                    star: false,
                    arrow: false,
                    controller: priceController,
                    textInputNumber: true),
                FieldsProductRequest(
                    titleText: 'Скидка  % ',
                    hintText: 'Введите размер скидки',
                    star: true,
                    arrow: false,
                    controller: compoundController,
                    textInputNumber: true),
                FieldsProductRequest(
                  titleText: 'Накопительные баллы ,% ',
                  hintText: 'Введите размер балла',
                  star: true,
                  arrow: false,
                  controller: pointsController,
                  textInputNumber: true,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const BloggerAd());
                  },
                  child: SizedBox(
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "Предлагая вознаграждение блогеру, вы принимаете условия ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          TextSpan(
                            text:
                                "Типового договора на оказание рекламных услуг\n",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.kPrimaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                FieldsProductRequest(
                    titleText: 'Вознаграждение блогеру ,% ',
                    hintText: 'Введите вознаграждение ',
                    star: true,
                    arrow: false,
                    controller: pointsBloggerController,
                    textInputNumber: true),
                FieldsProductRequest(
                  titleText: 'Категория',
                  hintText: cats!.name ?? 'Выберите категорию',
                  star: true,
                  arrow: false,
                  hintColor: true,
                  onPressed: () async {
                    // final data = await Get.to(const CatsAdminPage());
                    // if (data != null) {
                    //   final Cats cat = data;
                    //   setState(() {});
                    //   cats = cat;
                    // }
                  },
                ),
                FieldsProductRequest(
                  titleText: 'Название товара ',
                  hintText: 'Введите название товара',
                  star: false,
                  arrow: false,
                  controller: nameController,
                ),
                FieldsProductRequest(
                  titleText: 'Наименование бренда ',
                  hintText: brands!.name.toString(),
                  star: false,
                  arrow: true,
                  onPressed: () async {
                    final data = await Get.to(const BrandsAdminPage());
                    if (data != null) {
                      final Cats brand = data;
                      setState(() {});
                      brands = brand;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Общие характеристики',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                FieldsProductRequest(
                  titleText: 'Тип ',
                  hintText: subCats!.name.toString(),
                  hintColor: true,
                  star: true,
                  arrow: false,
                  onPressed: () async {
                    // final data = await Get.to(SubCatsAdminPage(cats: cats));
                    // if (data != null) {
                    //   final Cats cat = data;
                    //   setState(() {});
                    //   subCats = cat;
                    // }
                  },
                ),
                FieldsProductRequest(
                  titleText: 'Количество в комплекте ',
                  hintText: 'Выберите количество',
                  star: false,
                  arrow: false,
                  controller: countController,
                  textInputNumber: true,
                ),
                FieldsProductRequest(
                  titleText: 'Цвет ',
                  hintText: colors!.name.toString(),
                  hintColor: colors!.id != 0 ? true : false,
                  star: true,
                  arrow: true,
                  onPressed: () async {
                    final data = await Get.to(const ColorsAdminPage());
                    if (data != null) {
                      final Cats cat = data;
                      setState(() {});
                      colors = cat;
                    }
                  },
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Введите размер и количество',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            width: 102,
                            height: 38,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sizeName == '' ? 'Размер' : sizeName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      mockSizeAdds!.add(value as Cats);
                                      sizeId = value.id.toString();
                                      sizeName = value.name ?? 'Пустое';

                                      setState(() {});

                                      // mockSizeAdds!.forEach((element) {
                                      //   return print(element.name);
                                      // });
                                    },
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                    icon: SvgPicture.asset(
                                        'assets/icons/dropdown.svg'),
                                    position: PopupMenuPosition.under,
                                    offset: const Offset(0, 0),
                                    itemBuilder: (
                                      BuildContext bc,
                                    ) {
                                      return mockSizes!.map<PopupMenuItem>((e) {
                                        return PopupMenuItem(
                                          value: e,
                                          child: Text(
                                            e.name ?? 'Пустое',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                  )

                                  // SvgPicture.asset(
                                  //     'assets/icons/dropdown.svg')
                                ]),
                          ),
                          Container(
                            //alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(bottom: 6),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            width: 102,
                            height: 38,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: sizeCountController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Введите количество',
                                hintStyle: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (sizeCountController.text.isNotEmpty) {
                                bool exists = false;

                                sizeCountDto? sizeCountLast;
                                // if (optomCount.isNotEmpty) {

                                sizeCountLast = sizeCount.isNotEmpty
                                    ? sizeCount.last
                                    : null;
                                for (var element in sizeCount) {
                                  if (element.count ==
                                      sizeCountController.text) {
                                    exists = true;
                                    setState(() {});
                                  }
                                  continue;
                                }
                                //   }

                                if (!exists) {
                                  sizeCount.add(sizeCountDto(
                                      id: sizeId,
                                      name: sizeName,
                                      count: sizeCountController.text));

                                  setState(() {});
                                } else {
                                  // Get.to(() => {})
                                  Get.snackbar('Ошибка', 'Данные уже имеется!',
                                      backgroundColor: Colors.redAccent);
                                }
                              } else {
                                Get.snackbar('Ошибка', 'Нет данных!',
                                    backgroundColor: Colors.redAccent);
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              width: 102,
                              height: 38,
                              child: const Text(
                                '+',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60 * sizeCount.length.toDouble(),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sizeCount.length,
                      itemBuilder: ((context, index) {
                        return Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10, top: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              width: 102,
                              height: 38,
                              child: Text(
                                sizeCount[index].name,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10, top: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              width: 102,
                              height: 38,
                              child: Text(
                                sizeCount[index].count,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                sizeCount.removeAt(index);
                                setState(() {});
                              }),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 15, left: 10),
                                decoration: BoxDecoration(
                                    // color: AppColors.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                width: 102,
                                height: 38,
                                child: SvgPicture.asset(
                                    'assets/icons/basket_1.svg'),
                              ),
                            )
                          ],
                        );
                      })),
                ),
                FieldsProductRequest(
                  titleText: 'Ширина, мм ',
                  hintText: 'Введите ширину',
                  star: true,
                  arrow: false,
                  controller: widthController,
                  textInputNumber: true,
                ),
                FieldsProductRequest(
                  titleText: 'Высота, мм ',
                  hintText: 'Введите высоту',
                  star: true,
                  arrow: false,
                  controller: heightController,
                  textInputNumber: true,
                ),
                FieldsProductRequest(
                  titleText: 'Глубина, мм ',
                  hintText: 'Введите глубину',
                  star: true,
                  arrow: false,
                  controller: deepController,
                  textInputNumber: true,
                ),
                FieldsProductRequest(
                  titleText: 'Вес, г ',
                  hintText: 'Введите вес',
                  star: true,
                  arrow: false,
                  controller: massaController,
                  textInputNumber: true,
                ),
                FieldsProductRequest(
                  titleText: 'Дополнительно ',
                  hintText: 'Для дополнительной информации',
                  star: true,
                  arrow: false,
                  controller: descriptionController,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Предзаказ,если нет в наличии',
                        style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Switch(
                        onChanged: toggleSwitchBs,
                        value: isSwitchedBs,
                        activeColor: AppColors.kPrimaryColor,
                        activeTrackColor: AppColors.kPrimaryColor,
                        inactiveThumbColor:
                            const Color.fromRGBO(245, 245, 245, 1),
                        inactiveTrackColor:
                            const Color.fromRGBO(237, 237, 237, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Оптом',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            //alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(bottom: 6),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            width: 102,
                            height: 38,
                            child: TextField(
                              onChanged: (value) {
                                // setState(() {});
                              },
                              textAlign: TextAlign.center,
                              controller: optomCountController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: false),
                              onSubmitted: (_) {},
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Количество',
                                hintStyle: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            //alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(bottom: 6),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            width: 102,
                            height: 38,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: optomPriceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: false),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Введите цену',
                                hintStyle: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (optomPriceController.text.isNotEmpty) {
                                bool exists = false;

                                optomPriceDto? optomCountLast;
                                // if (optomCount.isNotEmpty) {

                                optomCountLast = optomCount.isNotEmpty
                                    ? optomCount.last
                                    : null;
                                for (var element in optomCount) {
                                  if (element.count ==
                                      optomCountController.text) {
                                    exists = true;
                                    setState(() {});
                                  }
                                  continue;
                                }
                                //   }

                                if (!exists) {
                                  optomCount.add(optomPriceDto(
                                      price: optomPriceController.text,
                                      count: optomCountController.text));

                                  setState(() {});
                                } else {
                                  // Get.to(() => {})
                                  Get.snackbar('Ошибка', 'Данные уже имеется!',
                                      backgroundColor: Colors.redAccent);
                                }
                              } else {
                                Get.snackbar('Ошибка', 'Нет данных!',
                                    backgroundColor: Colors.redAccent);
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              width: 102,
                              height: 38,
                              child: const Text(
                                '+',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60 * optomCount.length.toDouble(),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: optomCount.length,
                      itemBuilder: ((context, index) {
                        return Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10, top: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              width: 102,
                              height: 38,
                              child: Text(
                                optomCount[index].count,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 10, top: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              width: 102,
                              height: 38,
                              child: Text(
                                '${optomCount[index].price} тг',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                optomCount.removeAt(index);
                                setState(() {});
                              }),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, top: 15, left: 10),
                                decoration: BoxDecoration(
                                    // color: AppColors.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                width: 102,
                                height: 38,
                                child: SvgPicture.asset(
                                    'assets/icons/basket_1.svg'),
                              ),
                            )
                          ],
                        );
                      })),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8)),
                //   alignment: Alignment.center,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           SvgPicture.asset('assets/icons/bs4.svg'),
                //           const SizedBox(
                //             width: 10,
                //           ),
                //           const Text('Безопасная сделка'),
                //         ],
                //       ),
                //       Switch(
                //         onChanged: toggleSwitch,
                //         value: isSwitched,
                //         activeColor: AppColors.kPrimaryColor,
                //         activeTrackColor: AppColors.kPrimaryColor,
                //         inactiveThumbColor:
                //             const Color.fromRGBO(245, 245, 245, 1),
                //         inactiveTrackColor:
                //             const Color.fromRGBO(237, 237, 237, 1),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //  height: 10,
                //  ),
                const Text(
                  'Изоброжения товара',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _image.length != 0
                          ? SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: _image.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(children: [
                                      CircleAvatar(
                                        backgroundImage: FileImage(
                                          File(_image[index]!.path),
                                        ),
                                        radius: 34,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _image.removeAt(index);
                                          setState(() {
                                            _image;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ]),
                                  );
                                },
                              ),
                            )
                          : Container(),
                      const Text(
                        'Формат - jpg, png',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.kGray900),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                                title: "Изменить фото",
                                middleText: '',
                                textConfirm: 'Камера',
                                textCancel: 'Галерея',
                                titlePadding: const EdgeInsets.only(top: 40),
                                onConfirm: () {
                                  change = true;
                                  setState(() {
                                    change;
                                  });
                                  _getImage();
                                },
                                onCancel: () {
                                  change = false;
                                  setState(() {
                                    change;
                                  });
                                  _getImage();
                                });
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: change == false
                                      ? AppColors.kGray300
                                      : AppColors.kPrimaryColor,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Добавить изображение',
                                  style: TextStyle(
                                      color: AppColors.kGray300,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Минимальный/максимальный размер одной из сторон: от 500 до 2000 пикселей;- Основная фотография должна быть студийного качества на белом фоне без водяных знаков;- Минимальное/максимальное количество фотографий в карточке: от 3 до 5',
                        style: TextStyle(
                            color: AppColors.kGray300,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                const Text(
                  'Видео товара',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Формат - mp4, mov',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.kGray900),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                              title: "Изменить видео",
                              middleText: '',
                              textConfirm: 'Камера',
                              textCancel: 'Галерея',
                              titlePadding: const EdgeInsets.only(top: 40),
                              onConfirm: () {
                                change = true;
                                setState(() {
                                  change;
                                });
                                _getVideo();
                              },
                              onCancel: () {
                                change = false;
                                setState(() {
                                  change;
                                });
                                _getVideo();
                              });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/video.svg',
                                color: _video == null
                                    ? AppColors.kGray300
                                    : AppColors.kPrimaryColor,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Добавить видео',
                                style: TextStyle(
                                    color: AppColors.kGray300,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Разрешение — 1080×1350 px — для горизонтального; 566×1080 px — для вертикального; Расширение — mov, mp4; jpg, png; Размер — 4 ГБ — для видео, 30 МБ — для фото; Длительность — от 3 до 60 секунд.',
                        style: TextStyle(
                            color: AppColors.kGray300,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const FieldsProductRequest(
                //   titleText: 'Магазин ',
                //   hintText: 'Магазин',
                //   star: false,
                //   arrow: false,
                // ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.indigoAccent));
        }
      }),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () async {
            isChangeState = true;
            if (_image.isNotEmpty &&
                nameController.text.isNotEmpty &&
                priceController.text.isNotEmpty &&
                countController.text.isNotEmpty &&
                brands?.id != 0 &&
                colors?.id != 0) {
              await BlocProvider.of<ProductAdminCubit>(context).store(
                  priceController.text,
                  countController.text,
                  compoundController.text,
                  cats!.id.toString(),
                  subCats!.id.toString(),
                  brands!.id.toString(),
                  colors!.id.toString(),
                  descriptionController.text,
                  nameController.text,
                  heightController.text,
                  widthController.text,
                  massaController.text,
                  pointsController.text,
                  pointsBloggerController.text,
                  articulController.text,
                  currencyName,
                  isSwitchedBs,
                  deepController.text,
                  _image,
                  optomCount,
                  sizeCount,
                  _video != null ? _video!.path : null);
            } else {
              Get.snackbar("Ошибка", "Заполните данные",
                  backgroundColor: Colors.orangeAccent);
            }
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Сохранить',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}

class FieldsProductRequest extends StatefulWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final bool? hintColor;
  final TextEditingController? controller;
  final Cats? cats;
  final bool? textInputNumber;
  final void Function()? onPressed;

  const FieldsProductRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.hintColor,
    this.controller,
    this.cats,
    this.textInputNumber,
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  State<FieldsProductRequest> createState() => _FieldsProductRequestState();
}

class _FieldsProductRequestState extends State<FieldsProductRequest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.titleText,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.kGray900),
              ),
              widget.star != true
                  ? const Text(
                      '*',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.red),
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: TextField(
                controller: widget.controller,
                readOnly: (widget.textInputNumber == false ||
                        widget.textInputNumber == null)
                    ? true
                    : false,
                keyboardType: (widget.textInputNumber == false ||
                        widget.textInputNumber == null)
                    ? TextInputType.text
                    : const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color:
                          (widget.hintColor == null || widget.hintColor != true)
                              ? const Color.fromRGBO(194, 197, 200, 1)
                              : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    // borderRadius: BorderRadius.circular(3),
                  ),
                  suffixIcon: IconButton(
                    onPressed: widget.onPressed,
                    icon: widget.arrow == true
                        ? SvgPicture.asset('assets/icons/back_menu.svg',
                            color: Colors.grey)
                        : const SizedBox(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
