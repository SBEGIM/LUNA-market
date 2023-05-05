import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/admin/admin_app/presentation/base_admin.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/color_cubit.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/sub_caats_admin_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/data/bloc/brand_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/sub_cats_cubit.dart';
import 'package:haji_market/features/home/data/bloc/cats_cubit.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../../features/home/data/model/Cats.dart';
import '../../data/bloc/blogger_shop_products_cubit.dart';
import '../../data/bloc/blogger_shop_products_state.dart';
import '../../data/models/blogger_shop_products_model.dart';
import 'brands_admin_page.dart';
import 'cats_admin_page.dart';
import 'colors_admin_page.dart';

class EditProductPage extends StatefulWidget {
  final BloggerShopProductModel product;
  const EditProductPage({required this.product, Key? key}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;

  Future<void> _getImage() async {
    final image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  TextEditingController articulController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController compoundController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  int cat_id = 0;
  int brand_id = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController massaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Cats? cats;
  Cats? subCats;
  Cats? brands;
  Cats? colors;

  Future<void> CatById() async {
    cats = await BlocProvider.of<CatsCubit>(context)
        .catById(widget.product.catId.toString());
    brands = await BlocProvider.of<BrandCubit>(context)
        .brandById(widget.product.brandId.toString());
    subCats = await BlocProvider.of<SubCatsCubit>(context).subCatById(
        widget.product.brandId.toString(), widget.product.catId.toString());

    if (widget.product.color!.first != null) {
      colors = await BlocProvider.of<ColorCubit>(context)
          .ColorById(widget.product.color!.first);
    } else {
      Cats color = Cats(id: 0, name: 'Выберите цвет');
    }

    setState(() {
      cats;
      brands;
      subCats;
      colors;
    });
  }

  @override
  void initState() {
    CatById();

    articulController.text = widget.product.articul.toString();
    priceController.text = widget.product.price.toString();
    compoundController.text = widget.product.compound.toString();
    nameController.text = widget.product.name.toString();
    countController.text = widget.product.count.toString();
    cat_id = widget.product.catId ?? 0;
    brand_id = widget.product.brandId ?? 0;
    heightController.text = widget.product.height.toString();
    widthController.text = widget.product.width.toString();
    massaController.text = widget.product.massa.toString();
    descriptionController.text = widget.product.description.toString();

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
            'Редактировать товар',
            style: AppTextStyles.appBarTextStyle,
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: CustomBackButton(onTap: () {
              Navigator.pop(context);
            }),
          ),
        ),
        bottomSheet: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
          child: InkWell(
            onTap: () async {
              // await BlocProvider.of<BloggerShopProductsCubit>(context).update(
              //     priceController.text,
              //     countController.text,
              //     compoundController.text,
              //     cat_id.toString(),
              //     brand_id.toString(),
              //     descriptionController.text,
              //     nameController.text,
              //     heightController.text,
              //     widthController.text,
              //     massaController.text,
              //     widget.product.id.toString(),
              //     articulController.text);
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
        body: BlocConsumer<BloggerShopProductsCubit, BloggerShopProductsState>(
            listener: (context, state) {
          if (state is ChangeState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BaseAdmin()),
            );
          }
        }, builder: (context, state) {
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
                ),
                FieldsProductRequest(
                  titleText: 'Цена товара ',
                  hintText: 'Введите цену  ',
                  star: false,
                  arrow: false,
                  controller: priceController,
                ),
                FieldsProductRequest(
                  titleText: 'Скидка при оплате наличными, % ',
                  hintText: 'Введите размер скидки',
                  star: true,
                  arrow: false,
                  controller: compoundController,
                ),
                FieldsProductRequest(
                  titleText: 'Категория ',
                  hintText: cats!.name.toString(),
                  star: false,
                  arrow: true,
                  onPressed: () async {
                    final data = await Get.to(const CatsAdminPage());
                    if (data != null) {
                      final Cats cat = data;
                      setState(() {});
                      cats = cat;
                    }
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
                  star: false,
                  arrow: true,
                  onPressed: () async {
                    final data = await Get.to(SubCatsAdminPage(cats: cats));
                    if (data != null) {
                      final Cats cat = data;
                      setState(() {});
                      subCats = cat;
                    }
                  },
                ),
                FieldsProductRequest(
                  titleText: 'Количество в комплекте ',
                  hintText: 'Выберите количество',
                  star: false,
                  arrow: true,
                  controller: countController,
                ),
                FieldsProductRequest(
                  titleText: 'Цвет ',
                  hintText: colors!.name.toString(),
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
                FieldsProductRequest(
                  titleText: 'Ширина, мм ',
                  hintText: 'Введите ширину',
                  star: true,
                  arrow: false,
                  controller: widthController,
                ),
                FieldsProductRequest(
                  titleText: 'Высота, мм ',
                  hintText: 'Введите высоту',
                  star: true,
                  arrow: false,
                  controller: heightController,
                ),
                const FieldsProductRequest(
                  titleText: 'Глубина, мм ',
                  hintText: 'Введите глубину',
                  star: true,
                  arrow: false,
                ),
                FieldsProductRequest(
                  titleText: 'Вес, г ',
                  hintText: 'Введите вес',
                  star: true,
                  arrow: false,
                  controller: massaController,
                ),
                FieldsProductRequest(
                  titleText: 'Дополнительно ',
                  hintText: 'Для дополнительной информации',
                  star: true,
                  arrow: false,
                  controller: descriptionController,
                ),
                const SizedBox(
                  height: 10,
                ),
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
                                textCancel: 'Галлерея',
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
                              title: "Изменить видео",
                              middleText: '',
                              textConfirm: 'Камера',
                              textCancel: 'Галлерея',
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
                              SvgPicture.asset(
                                'assets/icons/video.svg',
                                color: change == false
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
                  height: 10,
                ),
                const FieldsProductRequest(
                  titleText: 'Магазин ',
                  hintText: 'Магазин',
                  star: false,
                  arrow: false,
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          );
        }));
  }
}

class FieldsProductRequest extends StatefulWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final TextEditingController? controller;
  final void Function()? onPressed;
  const FieldsProductRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
    this.onPressed,
    Key? key,
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
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(194, 197, 200, 1),
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
                          : SvgPicture.asset('')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
