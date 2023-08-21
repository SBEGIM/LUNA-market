import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/admin/my_products_admin/data/DTO/optom_price_dto.dart';
import 'package:haji_market/admin/my_products_admin/data/DTO/size_count_dto.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/characteristics_cubit.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/color_cubit.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/delete_image_cubit.dart' as deleteImageCubit;
import 'package:haji_market/admin/my_products_admin/data/bloc/product_admin_state.dart';
import 'package:haji_market/admin/my_products_admin/data/bloc/size_cubit.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/sub_caats_admin_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/data/bloc/sub_cats_cubit.dart';
import 'package:haji_market/features/home/data/bloc/cats_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../../features/drawer/data/bloc/brand_cubit.dart';
import '../../../../features/home/data/model/Cats.dart';
import '../../../../features/home/data/model/Characteristics.dart';
import '../../data/bloc/product_admin_cubit.dart';
import '../../data/models/admin_products_model.dart';
import 'brands_admin_page.dart';
import 'cats_admin_page.dart';
import 'colors_admin_page.dart';

class EditProductPage extends StatefulWidget {
  final AdminProductsModel product;
  const EditProductPage({required this.product, Key? key}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  // XFile? _image;

  List<XFile?> _image = [];
  XFile? _video;
  List<String> _networkImage = [];

  List<optomPriceDto> optomCount = [];
  List<sizeCountDto> sizeCount = [];

  List<Characteristics>? characteristics = [];
  List<Characteristics>? characteristicsValue = [];
  Characteristics? characteristicsValuelast;

  List<Characteristics>? subCharacteristics = [];
  List<Characteristics>? subCharacteristicsValue = [];
  Characteristics? subCharacteristicsValueLast;

  String characteristicName = '';
  String characteristicId = '';

  String subCharacteristicName = '';
  String subCharacteristicId = '';

  List<Cats>? mockSizes = [];
  List<Cats>? mockSizeAdds = [];

  String sizeName = '';

  String sizeId = '';
  String fulfillment = 'fbs';
  bool isSwitchedBs = false;
  bool isSwitchedFBS = false;
  final ImagePicker _picker = ImagePicker();
  bool change = false;
  VideoPlayerController? _controller;
  Future<void> initVideo(String path) async {
    _controller = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        _controller!.pause();
        setState(() {});
      });
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

    initVideo(_video!.path);
  }

  TextEditingController articulController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController compoundController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  int cat_id = 0;
  int color_id = 0;
  int sub_cat_id = 0;
  int brand_id = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController massaController = TextEditingController();
  TextEditingController deepController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sizeCountController = TextEditingController();
  TextEditingController sizePriceController = TextEditingController();
  TextEditingController optomPriceController = TextEditingController();
  TextEditingController optomCountController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  TextEditingController pointsBloggerController = TextEditingController();

  Cats? cats;
  Cats? subCats;
  Cats? brands;
  Cats? colors;

  Future<void> CatById() async {
    cats = await BlocProvider.of<CatsCubit>(context).catById(widget.product.catId.toString());

    if (widget.product.brandId != null) {
      brands = await BlocProvider.of<BrandCubit>(context).brandById(widget.product.brandId.toString());
    } else {
      brands = Cats(id: 0, name: 'Не выбрано');
    }

    subCats = await BlocProvider.of<SubCatsCubit>(context)
        .subCatById(widget.product.catId.toString(), widget.product.subCatId.toString());

    if (widget.product.color!.isNotEmpty) {
      colors = await BlocProvider.of<ColorCubit>(context).ColorById(widget.product.color!.first);
    } else {
      Cats colors = Cats(id: 0, name: 'Выберите цвет');
    }

    setState(() {
      cats;
      brands;
      subCats;
      colors;
    });
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

  void toggleSwitchFBS(bool value) {
    if (isSwitchedFBS == false) {
      setState(() {
        isSwitchedFBS = true;
        fulfillment = 'realFBS';
      });
    } else {
      setState(() {
        isSwitchedFBS = false;
        fulfillment = 'fbs';
      });
    }
  }

  @override
  void initState() {
    CatById();
    _sizeArray();
    _charactisticsArray();

    // BlocProvider.of<ProductAdminCubit>(context)
    articulController.text = widget.product.articul;
    priceController.text = widget.product.price != null ? widget.product.price.toString() : '0';
    compoundController.text = widget.product.compound != null ? widget.product.compound.toString() : '0';
    nameController.text = widget.product.name != null ? widget.product.name.toString() : '';
    countController.text = widget.product.count != null ? widget.product.count.toString() : '0';
    cat_id = widget.product.catId ?? 0;
    sub_cat_id = widget.product.subCatId ?? 0;
    brand_id = widget.product.brandId ?? 0;
    heightController.text = widget.product.height != null ? widget.product.height.toString() : '';
    widthController.text = widget.product.width != null ? widget.product.width.toString() : '';
    massaController.text = widget.product.massa != null ? widget.product.massa.toString() : '';
    descriptionController.text = widget.product.description != null ? widget.product.description.toString() : '';
    deepController.text = widget.product.deep != null ? widget.product.deep.toString() : '';
    _networkImage = widget.product.images ?? [];
    if (widget.product.bloc != null && widget.product.bloc!.isNotEmpty) {
      for (final BlocDTO e in widget.product.bloc!) {
        optomCount.add(optomPriceDto(price: (e.price ?? 0).toString(), count: (e.count ?? 0).toString()));
      }
    }
    pointsController.text = widget.product.point != null ? widget.product.point.toString() : '0';
    pointsBloggerController.text = widget.product.pointBlogger != null ? widget.product.pointBlogger.toString() : '0';
    super.initState();
  }

  void _sizeArray() async {
    mockSizes = await BlocProvider.of<SizeCubit>(context).sizes();
    if ((widget.product.sizeV1 ?? []).isNotEmpty) {
      for (final SizeDTO e in widget.product.sizeV1 ?? []) {
        sizeCount.add(sizeCountDto(
            id: mockSizes!.where((element) => element.name == e.name).isNotEmpty
                ? mockSizes!.where((element) => element.name == e.name).first.id.toString()
                : '-1',
            name: e.name ?? '',
            count: (e.count ?? 0).toString()));
      }
    }
    // setState(() {});
  }

  void _charactisticsArray() async {
    characteristics = await BlocProvider.of<CharacteristicsCubit>(context).characteristic();

    subCharacteristics = await BlocProvider.of<CharacteristicsCubit>(context).subCharacteristic();

    setState(() {});
    // if ((widget.product.sizeV1 ?? []).isNotEmpty) {
    //   for (final SizeDTO e in widget.product.sizeV1 ?? []) {
    //     sizeCount.add(sizeCountDto(
    //         id: mockSizes!.where((element) => element.name == e.name).isNotEmpty
    //             ? mockSizes!.where((element) => element.name == e.name).first.id.toString()
    //             : '-1',
    //         name: e.name ?? '',
    //         count: (e.count ?? 0).toString()));
    //   }
    // }
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
        body: Padding(
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
                readOnly: true,
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
                titleText: 'Накопительные баллы ,% ',
                hintText: 'Введите размер балла',
                star: true,
                arrow: false,
                controller: pointsController,
                textInputNumber: true,
              ),
              FieldsProductRequest(
                  titleText: 'Вознаграждение блогеру ,% ',
                  hintText: 'Введите вознаграждение ',
                  star: true,
                  arrow: false,
                  controller: pointsBloggerController,
                  textInputNumber: true),
              FieldsProductRequest(
                titleText: 'Категория ',
                hintText: cats?.name ?? "",
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
                hintText: brands?.name ?? "",
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
                style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              FieldsProductRequest(
                titleText: 'Тип ',
                hintText: subCats?.name ?? "",
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
                hintText: colors?.name ?? "Выберите цвет",
                star: true,
                arrow: true,
                onPressed: () async {
                  final data = await Get.to(const ColorsAdminPage());
                  if (data != null) {
                    final Cats cat = data;
                    color_id = cat.id ?? 0;
                    setState(() {});
                    colors = cat;
                  }
                },
              ),

              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Введите размер и количество',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          width: 111,
                          height: 38,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(
                              sizeName == '' ? 'Размер' : sizeName,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
                              icon: SvgPicture.asset('assets/icons/dropdown.svg'),
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
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          width: 102,
                          height: 38,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: sizeCountController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Введите количество',
                              hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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

                              sizeCountLast = sizeCount.isNotEmpty ? sizeCount.last : null;
                              for (var element in sizeCount) {
                                if (element.count == sizeCountController.text) {
                                  exists = true;
                                  setState(() {});
                                }
                                continue;
                              }
                              //   }

                              if (!exists) {
                                sizeCount
                                    .add(sizeCountDto(id: sizeId, name: sizeName, count: sizeCountController.text));

                                setState(() {});
                              } else {
                                // Get.to(() => {})
                                Get.snackbar('Ошибка', 'Данные уже имеется!', backgroundColor: Colors.redAccent);
                              }
                            } else {
                              Get.snackbar('Ошибка', 'Нет данных!', backgroundColor: Colors.redAccent);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration:
                                BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            width: 102,
                            height: 38,
                            child: const Text(
                              '+',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 70 * sizeCount.length.toDouble(),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sizeCount.length,
                    itemBuilder: ((context, index) {
                      return Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 10, top: 15),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            width: 102,
                            height: 38,
                            child: Text(
                              sizeCount[index].name,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 10, top: 15),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            width: 102,
                            height: 38,
                            child: Text(
                              sizeCount[index].count,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              sizeCount.removeAt(index);
                              setState(() {});
                            }),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10, top: 15, left: 10),
                              decoration: BoxDecoration(
                                  // color: AppColors.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              width: 102,
                              height: 38,
                              child: SvgPicture.asset('assets/icons/basket_1.svg'),
                            ),
                          )
                        ],
                      );
                    })),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Характиристика',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration:
                                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                      // width: 111,
                                      height: 38,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text(
                                          characteristicName == '' ? 'Параметр' : characteristicName,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                        ),
                                        PopupMenuButton(
                                          onSelected: (value) async {
                                            characteristicsValuelast = Characteristics(id: value.id, key: value.key);
                                            //sizeId = value.id.toString();
                                            characteristicId = value.id.toString();
                                            characteristicName = value.key ?? 'Пустое';
                                            subCharacteristics = await BlocProvider.of<CharacteristicsCubit>(context)
                                                .subCharacteristic(id: value.id.toString());

                                            setState(() {});
                                          },
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                          ),
                                          icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                                          position: PopupMenuPosition.under,
                                          offset: const Offset(0, 0),
                                          itemBuilder: (
                                            BuildContext bc,
                                          ) {
                                            return characteristics!.map<PopupMenuItem>((e) {
                                              return PopupMenuItem(
                                                value: e,
                                                child: Text(
                                                  e.key ?? 'Пустое',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            }).toList();
                                          },
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration:
                                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                      // width: 111,
                                      height: 38,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text(
                                          subCharacteristicName == '' ? 'Значение' : subCharacteristicName,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                        ),
                                        PopupMenuButton(
                                          onSelected: (value) {
                                            subCharacteristicsValueLast =
                                                Characteristics(id: value.id, value: value.value);

                                            // subCharacteristicsValue!.add(value as Characteristics);
                                            //sizeId = value.id.toString();

                                            subCharacteristicId = value.id.toString();
                                            subCharacteristicName = value.value ?? 'Пустое';

                                            subCharacteristics;
                                            setState(() {});
                                          },
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15.0),
                                            ),
                                          ),
                                          icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                                          position: PopupMenuPosition.under,
                                          offset: const Offset(0, 0),
                                          itemBuilder: (
                                            BuildContext bc,
                                          ) {
                                            return subCharacteristics!.map<PopupMenuItem>((e) {
                                              return PopupMenuItem(
                                                value: e,
                                                child: Text(
                                                  e.value ?? 'Пустое',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            }).toList();
                                          },
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (subCharacteristicsValueLast != null && characteristicsValuelast != null) {
                              bool exists = false;

                              for (int index = 0; index < characteristicsValue!.length; index++) {
                                if (characteristicsValue![index].key == characteristicsValuelast!.key) {
                                  if (subCharacteristicsValue![index].value == subCharacteristicsValueLast!.value) {
                                    exists = true;
                                    setState(() {});
                                  }
                                }
                                continue;
                              }

                              if (!exists) {
                                characteristicsValue!.add(Characteristics(
                                    id: characteristicsValuelast!.id!, key: characteristicsValuelast!.key));
                                subCharacteristicsValue!.add(Characteristics(
                                    id: subCharacteristicsValueLast!.id!, value: subCharacteristicsValueLast!.value));

                                setState(() {});
                              } else {
                                // Get.to(() => {})
                                Get.snackbar('Ошибка', 'Данные уже имеется!', backgroundColor: Colors.redAccent);
                              }
                            } else {
                              Get.snackbar('Ошибка', 'Нет данных!', backgroundColor: Colors.redAccent);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration:
                                BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            width: 102,
                            height: 38,
                            child: const Text(
                              '+',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 60 * (characteristicsValue?.length.toDouble() ?? 0),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: characteristicsValue?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 60,
                        minHeight: 40,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                characteristicsValue?[index].key ?? 'Пустое',
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                subCharacteristicsValue?[index].value ?? 'Пустое',
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: (() {
                              subCharacteristicsValue?.removeAt(index);
                              characteristicsValue?.removeAt(index);

                              setState(() {});
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                // color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              width: 102,
                              height: 38,
                              child: SvgPicture.asset('assets/icons/basket_1.svg'),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Габариты и вес с упаковкой',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
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
              FieldsProductRequest(
                titleText: 'Глубина, мм ',
                hintText: 'Введите глубину',
                star: true,
                arrow: false,
                controller: deepController,
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Предзаказ,если нет в наличии',
                      style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Switch(
                      onChanged: toggleSwitchBs,
                      value: isSwitchedBs,
                      activeColor: AppColors.kPrimaryColor,
                      activeTrackColor: AppColors.kPrimaryColor,
                      inactiveThumbColor: const Color.fromRGBO(245, 245, 245, 1),
                      inactiveTrackColor: const Color.fromRGBO(237, 237, 237, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Container(
                width: 166,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Real FBS',
                      style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Switch(
                      onChanged: toggleSwitchFBS,
                      value: isSwitchedFBS,
                      activeColor: AppColors.kPrimaryColor,
                      activeTrackColor: AppColors.kPrimaryColor,
                      inactiveThumbColor: const Color.fromRGBO(245, 245, 245, 1),
                      inactiveTrackColor: const Color.fromRGBO(237, 237, 237, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: 166,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'FBS',
                      style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Switch(
                      onChanged: toggleSwitchFBS,
                      value: !isSwitchedFBS,
                      activeColor: AppColors.kPrimaryColor,
                      activeTrackColor: AppColors.kPrimaryColor,
                      inactiveThumbColor: const Color.fromRGBO(245, 245, 245, 1),
                      inactiveTrackColor: const Color.fromRGBO(237, 237, 237, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              isSwitchedFBS == false
                  ? const Text(
                      'FBS - это схема продажи, при которой вы храните товары у себя на складе, следите за новыми заказами, собираете их и передаёте в доставку CDEK.',
                      style: TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w400),
                    )
                  : const Text(
                      'real FBS - это схема продажи, при которой вы храните товары у себя на складе, следите за новыми заказами, собираете их и передаёте в доставку CDEK.',
                      style: TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w400),
                    ),

              const SizedBox(height: 28),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Оптом',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          //alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(bottom: 6),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          width: 102,
                          height: 38,
                          child: TextField(
                            onChanged: (value) {
                              // setState(() {});
                            },
                            textAlign: TextAlign.center,
                            controller: optomCountController,
                            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                            onSubmitted: (_) {},
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Количество',
                              hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          width: 102,
                          height: 38,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: optomPriceController,
                            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Введите цену',
                              hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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

                              optomCountLast = optomCount.isNotEmpty ? optomCount.last : null;
                              for (var element in optomCount) {
                                if (element.count == optomCountController.text) {
                                  exists = true;
                                  setState(() {});
                                }
                                continue;
                              }
                              //   }

                              if (!exists) {
                                optomCount.add(
                                    optomPriceDto(price: optomPriceController.text, count: optomCountController.text));

                                setState(() {});
                              } else {
                                // Get.to(() => {})
                                Get.snackbar('Ошибка', 'Данные уже имеется!', backgroundColor: Colors.redAccent);
                              }
                            } else {
                              Get.snackbar('Ошибка', 'Нет данных!', backgroundColor: Colors.redAccent);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration:
                                BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            width: 102,
                            height: 38,
                            child: const Text(
                              '+',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            width: 102,
                            height: 38,
                            child: Text(
                              optomCount[index].count,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 10, top: 15),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            width: 102,
                            height: 38,
                            child: Text(
                              '${optomCount[index].price} тг',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              optomCount.removeAt(index);
                              setState(() {});
                            }),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10, top: 15, left: 10),
                              decoration: BoxDecoration(
                                  // color: AppColors.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              width: 102,
                              height: 38,
                              child: SvgPicture.asset('assets/icons/basket_1.svg'),
                            ),
                          )
                        ],
                      );
                    })),
              ),

              const Text(
                'Изоброжения товара',
                style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: BlocListener<deleteImageCubit.DeleteImageCubit, deleteImageCubit.DeleteImageState>(
                  listener: (context, state) {
                    if (state is deleteImageCubit.LoadedState) {
                      _networkImage.remove(state.deletingImagePath);
                      BlocProvider.of<deleteImageCubit.DeleteImageCubit>(context).toInit();
                      setState(() {});
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _image.isNotEmpty || _networkImage.isNotEmpty
                          ? SizedBox(
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                      children: (_networkImage)
                                          .map((e) => Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Stack(children: [
                                                  CircleAvatar(
                                                    backgroundImage: NetworkImage("http://185.116.193.73/storage/$e"),
                                                    radius: 34,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (widget.product.id != null) {
                                                        BlocProvider.of<deleteImageCubit.DeleteImageCubit>(context)
                                                            .deleteImage(imagePath: e, productId: widget.product.id!);
                                                      }
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ]),
                                              ))
                                          .toList()),
                                  Row(
                                      children: (_image)
                                          .map(
                                            (e) => Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Stack(children: [
                                                CircleAvatar(
                                                  backgroundImage: FileImage(
                                                    File(e!.path),
                                                  ),
                                                  radius: 34,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _image.removeAt(_image.indexWhere((element) => element == e));
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
                                            ),
                                          )
                                          .toList()),
                                ],
                              ),
                            )
                          : Container(),
                      const Text(
                        'Формат - jpg, png',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.kGray900),
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
                                textCancel: 'Фото',
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
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: change == false ? AppColors.kGray300 : AppColors.kPrimaryColor,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Добавить изображение',
                                  style:
                                      TextStyle(color: AppColors.kGray300, fontSize: 16, fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Минимальный/максимальный размер одной из сторон: от 500 до 2000 пикселей;- Основная фотография должна быть студийного качества на белом фоне без водяных знаков;- Минимальное/максимальное количество фотографий в карточке: от 3 до 5',
                        style: TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              const Text(
                'Видео товара',
                style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Формат - mp4,mpeg',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.kGray900),
                    ),
                    if (_video != null && _controller != null && _controller!.value.isInitialized)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                          child: SizedBox(
                            height: 200,
                            child: AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child:
                                  ClipRRect(borderRadius: BorderRadius.circular(12), child: VideoPlayer(_controller!)),
                            ),
                          ),
                        ),
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
                            textCancel: 'Фото',
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
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/video.svg',
                              color: _video == null ? AppColors.kGray300 : AppColors.kPrimaryColor,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Добавить видео',
                              style: TextStyle(color: AppColors.kGray300, fontSize: 16, fontWeight: FontWeight.w400),
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
                      style: TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 10,
              //),
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
        ),
        bottomSheet: BlocConsumer<ProductAdminCubit, ProductAdminState>(
          listener: (context, state) {
            if (state is ChangeState) {
              BlocProvider.of<ProductAdminCubit>(context).products('');
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            }
          },
          builder: (context, state) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
              child: InkWell(
                onTap: () async {
                  if (state is! LoadingState) {
                    if (fulfillment == 'fbs') {
                      if (widthController.text.isEmpty ||
                          heightController.text.isEmpty ||
                          deepController.text.isEmpty ||
                          massaController.text.isEmpty) {
                        Get.snackbar("Ошибка Доставка", "Заполните данные для доставки",
                            backgroundColor: Colors.orangeAccent);
                        return;
                      }
                    }

                    List<int> subIds = [];

                    if (subCharacteristicsValue?.isNotEmpty ?? false) {
                      subCharacteristicsValue!.forEach((e) => {subIds.add(e.id!)});
                    }

                    BlocProvider.of<ProductAdminCubit>(context).update(
                      priceController.text,
                      countController.text,
                      compoundController.text,
                      cats?.id.toString() ?? cat_id.toString(),
                      subCats?.id.toString() ?? sub_cat_id.toString(),
                      brand_id.toString(),
                      colors?.id.toString() ?? color_id.toString(),
                      descriptionController.text,
                      nameController.text,
                      heightController.text,
                      widthController.text,
                      massaController.text,
                      widget.product.id.toString(),
                      articulController.text,
                      '',
                      deepController.text,
                      _image,
                      optomCount,
                      sizeCount,
                      fulfillment,
                      _video != null ? _video!.path : null,
                      pointsController.text,
                      pointsBloggerController.text,
                      subCharacteristicsValue?.map((e) => e.id ?? 0).toList(),
                    );
                  }
                },
                child: Container(
                    height: 51,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.kPrimaryColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: state is LoadingState
                        ? const Center(child: CircularProgressIndicator.adaptive())
                        : const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Сохранить',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          )),
              ),
            );
          },
        ));
  }
}

class FieldsProductRequest extends StatefulWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final TextEditingController? controller;
  final void Function()? onPressed;
  final bool readOnly;
  final bool? textInputNumber;
  const FieldsProductRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
    this.onPressed,
    Key? key,
    this.readOnly = false,
    this.textInputNumber,
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
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.kGray900),
              ),
              widget.star != true
                  ? const Text(
                      '*',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.red),
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: TextField(
                readOnly: widget.readOnly,
                controller: widget.controller,
                keyboardType: (widget.textInputNumber == false || widget.textInputNumber == null)
                    ? TextInputType.text
                    : const TextInputType.numberWithOptions(signed: true, decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(194, 197, 200, 1), fontSize: 16, fontWeight: FontWeight.w400),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    // borderRadius: BorderRadius.circular(3),
                  ),
                  suffixIcon: IconButton(
                      onPressed: widget.onPressed,
                      icon: widget.arrow == true
                          ? SvgPicture.asset('assets/icons/back_menu.svg', color: Colors.grey)
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
