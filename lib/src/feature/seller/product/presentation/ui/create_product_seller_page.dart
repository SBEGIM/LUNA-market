import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/drawer/bloc/brand_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/country_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/cats_cubit.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
import 'package:haji_market/src/feature/home/data/model/country_model.dart';
import 'package:haji_market/src/feature/seller/product/bloc/color_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/size_count_seller_dto.dart';
import 'package:haji_market/src/feature/seller/product/bloc/last_articul_seller_cubit.dart'
    as lastArticul;
import 'package:haji_market/src/feature/seller/product/bloc/size_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/map_seller_picker.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_list_characteristics_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_cats_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_characteristics_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_optom_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_size_counts_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_size_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../home/data/model/cat_model.dart';
import '../../../../home/data/model/characteristic_model.dart';
import '../../data/DTO/color_count_seller_dto.dart';
import '../../data/DTO/optom_price_seller_dto.dart';
import '../../bloc/characteristic_seller_cubit.dart';
import '../../bloc/product_seller_cubit.dart';
import '../../bloc/product_seller_state.dart';

@RoutePage()
class CreateProductSellerPage extends StatefulWidget
    implements AutoRouteWrapper {
  final CatsModel cat;
  final CatsModel? subCat;
  const CreateProductSellerPage(
      {required this.cat, required this.subCat, super.key});

  @override
  State<CreateProductSellerPage> createState() =>
      _CreateProductSellerPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductSellerCubit(productAdminRepository: ProductSellerRepository())
            ..products(''),
      child: this,
    );
  }
}

class _CreateProductSellerPageState extends State<CreateProductSellerPage> {
  CatsModel? cats;
  CatsModel? subCats;
  CatsModel? brands;
  CatsModel? colors;

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
  TextEditingController optomTotalController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  TextEditingController ndsController = TextEditingController();
  TextEditingController pointsBloggerController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController deepController = TextEditingController();

  final List<XFile?> _image = [];
  XFile? _video;
  VideoPlayerController? _controller;
  Future<void> initVideo(String path) async {
    _controller = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        _controller!.pause();
        setState(() {});
      });
  }

  final ImagePicker _picker = ImagePicker();

  bool change = false;

  String colorName = '';

  String sizeName = '';
  String sizeId = '';
  String currencyName = '₽';
  String compoundValue = '₽';

  String fulfillment = 'fbs';

  List<CatsModel> _cats = [];
  List<CatsModel> _subCats = [];
  List<CatsModel> _brands = [];

  List<ColorCountSellerDto> colorCount = [];
  List<CatsModel>? mockSizeAdds = [];
  List<OptomPriceSellerDto> optomCount = [];
  List<SizeCountSellerDto> sizeCount = [];
  List<CatsModel>? mockSizes = [];

  List<CatsModel>? mockColors = [];
  List<CatsModel>? checkColors = [];

  List<CharacteristicsModel>? characteristics = [];
  List<CharacteristicsModel>? characteristicsValue = [];
  CharacteristicsModel? characteristicsValuelast;

  List<CharacteristicsModel>? subCharacteristics = [];
  List<CharacteristicsModel>? subCharacteristicsValue = [];
  CharacteristicsModel? subCharacteristicsValueLast;

  String characteristicName = '';
  String characteristicId = '';

  String subCharacteristicName = '';
  String subCharacteristicId = '';

  bool isSwitched = false;
  bool isSwitchedBs = false;
  bool isSwitchedFBS = false;
  bool isChangeState = false;
  bool isSwitchedOptom = false;

  String _locationSelect = 'Выбор лакации';
  String _locationSeller = 'Не выбрано';

  List<CatsModel> _locations = [
    CatsModel(id: 0, name: 'Не выбрано'),
    CatsModel(id: 1, name: 'Без ограничений'),
    CatsModel(id: 2, name: 'Вся Россия'),
    CatsModel(id: 3, name: 'Регион'),
    CatsModel(id: 4, name: 'Город/населенный пункт'),
    CatsModel(id: 5, name: 'Моя локация'),
  ];

  List<CatsModel> _locationsValues = [
    CatsModel(id: 0, name: 'Пункт 1'),
    CatsModel(id: 1, name: 'Пункт 2'),
    CatsModel(id: 2, name: 'Пункт 3'),
    CatsModel(id: 3, name: 'Пункт 4'),
    CatsModel(id: 4, name: 'Пункт 5'),
    CatsModel(id: 5, name: 'Пункт 6'),
  ];

  List<CatsModel> _regions = [];

  void _regionsArray() async {
    final List<CountryModel> data =
        await BlocProvider.of<CountryCubit>(context).countryList();
    _regions.clear();

    for (int i = 0; i < data.length; i++) {
      _regions.add(CatsModel(id: data[i].id, name: data[i].name));
    }
  }

  void _citiesArray(country) async {
    final List<CityModel> data =
        await BlocProvider.of<CityCubit>(context).citiesList(country);

    _regions.clear();
    for (int i = 0; i < data.length; i++) {
      _regions.add(CatsModel(id: data[i].code, name: data[i].city));
    }
  }

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

  void toggleSwitchOptom(bool value) {
    if (GetStorage().read('seller_partner') != '1' && value == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SizedBox(
              height: 224,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Оптовая продажа недоступна",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Функция станет доступна после подтверждения партнёрства",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32),
                    DefaultButton(
                        text: 'Понятно',
                        press: () {
                          Navigator.pop(context);
                        },
                        color: AppColors.kWhite,
                        backgroundColor: AppColors.mainPurpleColor,
                        width: 300)
                  ],
                ),
              ),
            ),
          );
        },
      );

      return;
    }

    if (isSwitchedOptom == false) {
      setState(() {
        isSwitchedOptom = true;
      });
    } else {
      setState(() {
        isSwitchedOptom = false;
      });
    }
  }

  bool isCheckedFBS = false;

  void toggleCheckboxFBS(bool? value) {
    setState(() {
      isCheckedFBS = value ?? false;
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

  void _sizeArray() async {
    mockSizes = await BlocProvider.of<SizeSellerCubit>(context).sizes();
  }

  void _colorArray() async {
    mockColors = await BlocProvider.of<ColorSellerCubit>(context).listColor();
  }

  void _charactisticsArray() async {
    characteristics = await BlocProvider.of<CharacteristicSellerCubit>(context)
        .characteristic();

    subCharacteristics =
        await BlocProvider.of<CharacteristicSellerCubit>(context)
            .subCharacteristic();

    setState(() {});
  }

  @override
  void initState() {
    cats = widget.cat;
    subCats = widget.subCat;
    brands = CatsModel(id: 0, name: 'Выберите из списка');
    colors = CatsModel(id: 0, name: 'Выберите цвет');

    if (BlocProvider.of<metaCubit.MetaCubit>(context).state
        is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }

    if (BlocProvider.of<BrandCubit>(context).state is! metaState.LoadedState) {
      BlocProvider.of<BrandCubit>(context).brands();
    }

    BlocProvider.of<lastArticul.LastArticulSellerCubit>(context)
        .getLastArticul();

    if (BlocProvider.of<CatsCubit>(context).state is! LoadedState) {
      BlocProvider.of<CatsCubit>(context).cats();
    }

    if (BlocProvider.of<SubCatsCubit>(context).state is! LoadedState) {
      BlocProvider.of<SubCatsCubit>(context).subCats(cats?.id ?? 26);
    }

    if (BlocProvider.of<CountryCubit>(context).state is! LoadedState) {
      BlocProvider.of<CountryCubit>(context).country();
    }

    if (BlocProvider.of<CityCubit>(context).state is! LoadedState) {
      BlocProvider.of<CityCubit>(context).citiesCdek('RU' ?? 'KZ');
    }

    _sizeArray();
    _colorArray();
    _charactisticsArray();

    super.initState();
  }

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг'
  ];

  List<String> metasBody = [];

  // Параметры, которые можно менять

  int filledCount = 1;
  double segmentHeight = 8;
  double segmentWidth = 8;
  double segmentSpacing = 2;
  int filledSegments = 1; // Начинаем с 1 заполненного сегмента
  int totalSegments = 6; // Всего сегментов
  Color filledColor = AppColors.mainPurpleColor;
  Color emptyColor = Colors.grey[200]!;
  double spacing = 5.0;
  String title = "Основная информация";

  void increaseProgress() {
    if (filledSegments < totalSegments) {
      setState(() {
        filledSegments++;
      });
    }
  }

  // Функция для уменьшения прогресса
  void decreaseProgress() {
    if (filledSegments > 0) {
      setState(() {
        filledSegments--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Добавить товар',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<ProductSellerCubit, ProductAdminState>(
          listener: (context, state) {
        if (state is ChangeState && isChangeState) {
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const BaseAdmin()),
          // );
          isChangeState = false;
        }
      }, builder: (context, state) {
        if (state is LoadedState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Прогресс-бар с пробелами
                    SizedBox(
                      height: segmentHeight,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totalSegments,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: segmentSpacing),
                        itemBuilder: (context, index) {
                          bool isFilled = index < filledCount;
                          return Container(
                            width: (MediaQuery.of(context).size.width -
                                    (totalSegments - 1) * segmentSpacing -
                                    32) /
                                totalSegments,
                            decoration: BoxDecoration(
                              color: isFilled ? filledColor : emptyColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 8),
                    // Text(
                    //   '$filledCount из $totalSegments разделов заполнено',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.grey[600],
                    //   ),
                    // ),
                    // Управляющие кнопки (для демо)
                    // Row(
                    //   children: [
                    //     IconButton(
                    //         icon: Icon(Icons.remove),
                    //         onPressed: () {
                    //           filledCount =
                    //               filledCount > 0 ? filledCount - 1 : 0;

                    //           if (filledCount == 1) {
                    //             title = 'Основная информация';
                    //           }
                    //           if (filledCount == 2) {
                    //             title = 'Способ реализации';
                    //           }
                    //           if (filledCount == 3) {
                    //             title = 'Описание';
                    //           }
                    //           if (filledCount == 4) {
                    //             title = 'Фото и видео';
                    //           }
                    //           if (filledCount == 5) {
                    //             title = 'Условия продажи';
                    //           }
                    //           setState(() {});
                    //         }),
                    //     IconButton(
                    //         icon: Icon(Icons.add),
                    //         onPressed: () {
                    //           filledCount = filledCount < totalSegments
                    //               ? filledCount + 1
                    //               : totalSegments;

                    //           if (filledCount == 1) {
                    //             title = 'Основная информация';
                    //           }
                    //           if (filledCount == 2) {
                    //             title = 'Способ реализации';
                    //           }
                    //           if (filledCount == 3) {
                    //             title = 'Описание';
                    //           }
                    //           if (filledCount == 4) {
                    //             title = 'Фото и видео';
                    //           }
                    //           if (filledCount == 5) {
                    //             title = 'Условия продажи';
                    //           }
                    //           setState(() {});
                    //         }),
                    //   ],
                    // ),
                  ],
                ),
                if (filledCount == 1)
                  FieldsProductRequest(
                    titleText: 'Категория и тип',
                    hintText: cats!.name ?? 'Выберите категорию',
                    star: true,
                    arrow: true,
                    hintColor: true,
                    onPressed: () async {
                      if (_cats.isEmpty) {
                        _cats = await BlocProvider.of<CatsCubit>(context)
                            .catsList();
                      }

                      showSellerCatsOptions(context, 'Категория и тип', _cats,
                          (value) {
                        // BlocProvider.of<CatsCubit>(context).searchCats(value);

                        setState(() {
                          cats = value;
                        });
                      });
                      // final data = await Get.to(const CatsAdminPage());
                      // if (data != null) {
                      //   final Cats cat = data;
                      //   setState(() {});
                      //   cats = cat;
                      // }
                    },
                  ),

                if (filledCount == 1)
                  FieldsProductRequest(
                    titleText: 'Подкатегория',
                    hintText: subCats?.name ?? '',
                    hintColor: true,
                    star: true,
                    arrow: true,
                    onPressed: () async {
                      if (_subCats.isEmpty) {
                        _subCats = await BlocProvider.of<SubCatsCubit>(context)
                            .subCatsList();
                      }
                      showSellerCatsOptions(context, 'Подкатегория', _subCats,
                          (value) {
                        setState(() {
                          subCats = value;
                        });
                      });
                      // final data = await Get.to(SubCatsAdminPage(cats: cats));
                      // if (data != null) {
                      //   final Cats cat = data;
                      //   setState(() {});
                      //   subCats = cat;
                      // }
                    },
                  ),
                if (filledCount == 1)
                  FieldsProductRequest(
                    titleText: 'Бренд',
                    hintText: brands!.name.toString(),
                    hintColor: true,
                    star: true,
                    arrow: true,
                    onPressed: () async {
                      if (_brands.isEmpty) {
                        _brands = await BlocProvider.of<BrandCubit>(context)
                            .brandsList();
                      }
                      showSellerCatsOptions(
                        context,
                        'Бренд',
                        _brands,
                        (value) {
                          setState(() {
                            brands = value;
                          });

                          // print(value);
                          // BlocProvider.of<BrandCubit>(context)
                          //     .searchBrand(value);
                          // final CatsModel brand = data;
                          // setState(() {});
                          // brands = brand;
                        },
                      );

                      // final data = await Get.to(const BrandSellerPage());
                      // if (data != null) {
                      //   final CatsModel brand = data;
                      //   setState(() {});
                      //   brands = brand;
                      // }
                    },
                  ),
                if (filledCount == 1)
                  FieldsProductRequest(
                    titleText: 'Название товара ',
                    hintText: 'Введите название товара',
                    star: false,
                    arrow: false,
                    controller: nameController,
                  ),
                if (filledCount == 1)
                  BlocListener<lastArticul.LastArticulSellerCubit,
                      lastArticul.LastArticulSellerState>(
                    listener: (context, stateArticul) {
                      if (stateArticul is lastArticul.LoadedState) {
                        articulController.text = getFormattedArticle(
                            stateArticul.articul.toString());
                        setState(() {});
                      }
                    },
                    child: FieldsProductRequest(
                      titleText: 'Артикул/SKU',
                      hintText: 'Введите артикул  ',
                      star: false,
                      arrow: false,
                      controller: articulController,
                      textInputNumber: true,
                      readOnly: true,
                    ),
                  ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 4.0, bottom: 10),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Row(
                //         children: [
                //           Text(
                //             'Валюта',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w400,
                //                 fontSize: 12,
                //                 color: AppColors.kGray900),
                //           ),
                //           Text(
                //             '*',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w400,
                //                 fontSize: 12,
                //                 color: Colors.red),
                //           )
                //         ],
                //       ),
                //       const SizedBox(
                //         height: 4,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(10)),
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 14.0),
                //           child: TextField(
                //             // controller: ,
                //             keyboardType: TextInputType.text,
                //             decoration: InputDecoration(
                //                 border: InputBorder.none,
                //                 hintText: currencyName,
                //                 hintStyle: const TextStyle(
                //                     color: Color.fromRGBO(194, 197, 200, 1),
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.w400),
                //                 enabledBorder: const UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.white),
                //                   // borderRadius: BorderRadius.circular(3),
                //                 ),
                //                 // suffixIcon: IconButton(
                //                 //   onPressed: widget.onPressed,
                //                 //   icon: widget.arrow == true
                //                 //       ? SvgPicture.asset('assets/icons/back_menu.svg',
                //                 //           color: Colors.grey)
                //                 //       : SvgPicture.asset(''),
                //                 // ),
                //                 suffixIcon: PopupMenuButton(
                //                   onSelected: (value) {
                //                     currencyName = value;

                //                     setState(() {});

                //                     // mockSizeAdds!.forEach((element) {
                //                     //   return print(element.name);
                //                     // });
                //                   },
                //                   shape: const RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.all(
                //                       Radius.circular(15.0),
                //                     ),
                //                   ),
                //                   icon: SvgPicture.asset(
                //                       'assets/icons/dropdown.svg'),
                //                   position: PopupMenuPosition.under,
                //                   offset: const Offset(0, 0),
                //                   itemBuilder: (
                //                     BuildContext bc,
                //                   ) {
                //                     return const [
                //                       PopupMenuItem(
                //                         value: 'KZT',
                //                         child: Text(
                //                           'KZT',
                //                           style: TextStyle(
                //                             color: Colors.black,
                //                           ),
                //                         ),
                //                       ),
                //                       PopupMenuItem(
                //                         value: 'RUB',
                //                         child: Text(
                //                           'RUB',
                //                           style: TextStyle(
                //                             color: Colors.black,
                //                           ),
                //                         ),
                //                       ),
                //                     ];
                //                   },
                //                 )),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                if (filledCount == 1)
                  FieldsProductRequest(
                    titleText: 'Описание товара',
                    hintText: 'Расскажите подробнее о товаре',
                    star: true,
                    arrow: false,
                    controller: descriptionController,
                    maxLines: 4,
                  ),
                if (filledCount == 1)
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FieldsProductRequest(
                              titleText: 'Цена товара ',
                              hintText: 'Введите цену  ',
                              star: false,
                              arrow: false,
                              controller: priceController,
                              textInputNumber: true),
                        ),
                        SizedBox(width: 6),
                        Container(
                          width: 96,
                          height: 42,
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                              color: AppColors.kBackgroundColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(currencyName),
                              PopupMenuButton(
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
                                      value: '₽',
                                      child: Text(
                                        'Российский рубль (RUB)',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: '₸',
                                      child: Text(
                                        'Казахстанский тенге (KZT)',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: '₽',
                                      child: Text(
                                        'Белорусский рубль (BYN)',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (filledCount == 1)
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FieldsProductRequest(
                              titleText: 'Скидка ,% ',
                              hintText: 'Введите размер скидки',
                              star: true,
                              arrow: false,
                              controller: compoundController,
                              textInputNumber: true),
                        ),
                        SizedBox(width: 6),
                        Container(
                          width: 96,
                          height: 42,
                          padding: EdgeInsets.all(6),
                          margin: EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                              color: AppColors.kBackgroundColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(compoundValue),
                              PopupMenuButton(
                                onSelected: (value) {
                                  compoundValue = value;

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
                                      value: '₽',
                                      child: Text(
                                        'Рубль, ₽',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: ' % ',
                                      child: Text(
                                        'Процент, % ',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                if (filledCount == 1)
                  FieldsProductRequest(
                    titleText: 'НДС (налог на добавленную стоимость)',
                    hintText: 'Введите НДС',
                    star: true,
                    arrow: true,
                    controller: ndsController,
                    textInputNumber: true,
                    onPressed: () async {
                      if (_brands.isEmpty) {
                        _brands = await BlocProvider.of<BrandCubit>(context)
                            .brandsList();
                      }

                      final List<CatsModel> _nds = [
                        CatsModel(id: 0, name: '5 %'),
                        CatsModel(id: 1, name: '7 %'),
                        CatsModel(id: 2, name: '10 %'),
                        CatsModel(id: 3, name: '20 %'),
                        CatsModel(id: 4, name: 'Не облагается'),
                      ];

                      showSellerCatsOptions(
                        context,
                        'Выбор НДС',
                        _nds,
                        (value) {
                          final CatsModel _data = value;

                          setState(() {
                            ndsController.text = _data.name!;
                          });

                          // print(value);
                          // BlocProvider.of<BrandCubit>(context)
                          //     .searchBrand(value);
                          // final CatsModel brand = data;
                          // setState(() {});
                          // brands = brand;
                        },
                      );
                    },
                  ),
                if (filledCount == 1)
                  FieldsProductRequest(
                    titleText: 'Накопительные бонусы ,% ',
                    hintText: 'Введите размер бонуса',
                    star: true,
                    arrow: false,
                    controller: pointsController,
                    textInputNumber: true,
                  ),

                if (filledCount == 1)
                  FieldsProductRequest(
                      titleText: 'Вознаграждение блогеру ,% ',
                      hintText: 'Введите вознаграждение ',
                      star: true,
                      arrow: false,
                      controller: pointsBloggerController,
                      textInputNumber: true),
                if (filledCount == 1)
                  BlocBuilder<metaCubit.MetaCubit, metaState.MetaState>(
                      builder: (context, state) {
                    if (state is metaState.LoadedState) {
                      metasBody.addAll([
                        state.metas.terms_of_use!,
                        state.metas.privacy_policy!,
                        state.metas.contract_offer!,
                        state.metas.shipping_payment!,
                        state.metas.TTN!,
                      ]);
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => MetasPage(
                                title: metas[3],
                                body: metasBody[3],
                              ));
                        },
                        child: SizedBox(
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
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
                                      color: AppColors.mainPurpleColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.indigoAccent));
                    }
                  }),

                // if (filledCount == 2)
                //   const Text(
                //     'Общие характеристики',
                //     style: TextStyle(
                //         color: AppColors.kGray900,
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700),
                //   ),

                if (filledCount == 1)
                  FieldsProductRequest(
                    titleText: 'Количество в наличии ',
                    hintText: 'Введите количество',
                    star: false,
                    arrow: false,
                    controller: countController,
                    textInputNumber: true,
                  ),
                if (filledCount == 1)
                  Container(
                    height: 82,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.kGray2,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Разрешить предзаказ',
                                style: TextStyle(
                                    color: AppColors.kLightBlackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Если товара нет в наличии — можно ли оформить заказ?',
                                style: TextStyle(
                                    color: AppColors.kLightBlackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            switchTheme: SwitchThemeData(
                              trackOutlineWidth: MaterialStateProperty.all(
                                  0), // Полностью убираем границу
                            ),
                          ),
                          child: Switch(
                            onChanged: toggleSwitchBs,
                            value: isSwitchedBs,
                            activeColor: AppColors.kWhite,
                            activeTrackColor: AppColors.mainPurpleColor,
                            inactiveThumbColor: AppColors.kGray300,
                            inactiveTrackColor: AppColors.kGray2,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                      ],
                    ),
                  ),

                if (filledCount == 1) SizedBox(height: 100),
                SizedBox(height: 20),
                if (filledCount == 2)
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: 82,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: AppColors.kGray2,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Включить продажу оптом',
                                      style: TextStyle(
                                          color: AppColors.kLightBlackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Text(
                                      'Доступно только для партнёров платформы',
                                      style: TextStyle(
                                          color: AppColors.kLightBlackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Theme(
                                data: Theme.of(context).copyWith(
                                  switchTheme: SwitchThemeData(
                                    trackOutlineWidth:
                                        MaterialStateProperty.all(
                                            0), // Полностью убираем границу
                                  ),
                                ),
                                child: Switch(
                                  onChanged: toggleSwitchOptom,
                                  value: isSwitchedOptom,
                                  activeColor: AppColors.kWhite,
                                  activeTrackColor: AppColors.mainPurpleColor,
                                  inactiveThumbColor: AppColors.kGray300,
                                  inactiveTrackColor: AppColors.kGray2,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              )
                            ],
                          ),
                        ),

                        // GetStorage().read('seller_partner') == '1'
                        //     ? Container(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 10),
                        //         margin: const EdgeInsets.only(bottom: 10),
                        //         decoration: BoxDecoration(
                        //             color: const Color(0xff42BB5D),
                        //             borderRadius: BorderRadius.circular(8)),
                        //         alignment: Alignment.center,
                        //         // width: 343,
                        //         height: 38,
                        //         child: const Row(
                        //           children: [
                        //             Icon(
                        //               Icons.check_circle,
                        //               color: Colors.white,
                        //             ),
                        //             SizedBox(width: 10),
                        //             Text(
                        //               'У вас есть партнерство с этой компанией.',
                        //               style: TextStyle(
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   color: Colors.white),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     : const SizedBox.shrink(),

                        // Row(
                        //   children: [
                        //     Container(
                        //       //alignment: Alignment.topCenter,
                        //       padding: const EdgeInsets.only(bottom: 6),
                        //       margin: const EdgeInsets.only(right: 10),
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(8)),
                        //       width: 102,
                        //       height: 38,
                        //       child: TextField(
                        //         onChanged: (value) {
                        //           // setState(() {});
                        //         },
                        //         textAlign: TextAlign.center,
                        //         controller: optomCountController,
                        //         keyboardType:
                        //             const TextInputType.numberWithOptions(
                        //                 signed: true, decimal: false),
                        //         onSubmitted: (_) {},
                        //         decoration: const InputDecoration(
                        //           border: InputBorder.none,
                        //           hintText: 'Количество',
                        //           hintStyle: TextStyle(
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w400),
                        //           enabledBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             // borderRadius: BorderRadius.circular(3),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       //alignment: Alignment.topCenter,
                        //       padding: const EdgeInsets.only(bottom: 6),
                        //       margin: const EdgeInsets.only(right: 10),
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(8)),
                        //       width: 102,
                        //       height: 38,
                        //       child: TextField(
                        //         textAlign: TextAlign.center,
                        //         controller: optomPriceController,
                        //         keyboardType:
                        //             const TextInputType.numberWithOptions(
                        //                 signed: true, decimal: false),
                        //         decoration: const InputDecoration(
                        //           border: InputBorder.none,
                        //           hintText: 'Введите цену',
                        //           hintStyle: TextStyle(
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w400),
                        //           enabledBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             // borderRadius: BorderRadius.circular(3),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       //alignment: Alignment.topCenter,
                        //       padding: const EdgeInsets.only(bottom: 6),
                        //       margin: const EdgeInsets.only(right: 10),
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(8)),
                        //       width: 50,
                        //       height: 38,
                        //       child: TextField(
                        //         textAlign: TextAlign.center,
                        //         controller: optomTotalController,
                        //         keyboardType:
                        //             const TextInputType.numberWithOptions(
                        //                 signed: true, decimal: false),
                        //         decoration: const InputDecoration(
                        //           border: InputBorder.none,
                        //           hintText: 'В наличии шт',
                        //           hintStyle: TextStyle(
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w400),
                        //           enabledBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             // borderRadius: BorderRadius.circular(3),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                if (filledCount == 2) SizedBox(height: 5),
                if (filledCount == 2)
                  SizedBox(
                    height: optomCount.length * 115,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: optomCount.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.kBackgroundColor),
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Минимальный заказ: ',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.kGray300,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          '${optomCount[index].count} шт',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Цена за 1 шт, (оптовая): ',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.kGray300,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          '${optomCount[index].price} ₽',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Количество в наличии: ',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.kGray300,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          '${optomCount[index].total} шт',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: (() {
                                    optomCount.removeAt(index);
                                    setState(() {});
                                  }),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          );
                        })),
                  ),

                if (filledCount == 2 && isSwitchedOptom)
                  InkWell(
                    onTap: () {
                      showSellerOptomOptions(
                          context, 'Добавить оптовую продажу',
                          (OptomPriceSellerDto value) {
                        optomPriceController.text = value.price;
                        optomCountController.text = value.count;
                        optomTotalController.text = value.total;

                        if (GetStorage().read('seller_partner') != '1') {
                          Get.snackbar('Ошибка оптом', 'У вас нет партнерство',
                              backgroundColor: Colors.redAccent);

                          optomPriceController.clear();
                          optomCountController.clear();
                          optomTotalController.clear();

                          return;
                        }
                        if (optomPriceController.text.isNotEmpty) {
                          bool exists = false;

                          OptomPriceSellerDto? optomCountLast;
                          // if (optomCount.isNotEmpty) {

                          optomCountLast =
                              optomCount.isNotEmpty ? optomCount.last : null;
                          for (var element in optomCount) {
                            if (element.count == optomCountController.text) {
                              exists = true;
                              setState(() {});
                            }
                            continue;
                          }
                          //   }

                          if (!exists) {
                            optomCount.add(OptomPriceSellerDto(
                                price: optomPriceController.text,
                                count: optomCountController.text,
                                total: optomTotalController.text));

                            setState(() {});
                          } else {
                            // Get.to(() => {})
                            Get.snackbar('Ошибка', 'Данные уже имеется!',
                                backgroundColor: Colors.redAccent);
                            optomPriceController.clear();
                            optomCountController.clear();
                            optomTotalController.clear();
                          }
                        } else {
                          Get.snackbar('Ошибка', 'Нет данных!',
                              backgroundColor: Colors.redAccent);
                          optomPriceController.clear();
                          optomCountController.clear();
                          optomTotalController.clear();
                        }

                        optomPriceController.clear();
                        optomCountController.clear();
                        optomTotalController.clear();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: GetStorage().read('seller_partner') == '1'
                              ? AppColors.mainBackgroundPurpleColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 38,
                      child: const Text(
                        '+ Добавить оптом',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainPurpleColor),
                      ),
                    ),
                  ),
                // if (filledCount == 3)
                //   SizedBox(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           'Размер',
                //           style: TextStyle(
                //               fontSize: 16, fontWeight: FontWeight.w700),
                //         ),
                //         const SizedBox(height: 10),
                //         GestureDetector(
                //           onTap: () {
                //             showSellerSizeOptions(
                //                 context, 'Добавить размеры', mockSizes,
                //                 (SizeCountSellerDto value) {
                //               sizeId = value.id;
                //               sizeName = value.name;
                //               sizeCountController.text = value.count;

                //               if (sizeCountController.text.isNotEmpty) {
                //                 bool exists = false;

                //                 //  Cats? sizeCountLast;
                //                 // if (optomCount.isNotEmpty) {

                //                 // sizeCountLast = mockSizeAdds!.isEmpty ? mockSizeAdds!.last : null;
                //                 for (var element in mockSizeAdds!) {
                //                   if (element.name == sizeName) {
                //                     exists = true;
                //                     setState(() {});
                //                   }
                //                   continue;
                //                 }
                //                 //   }

                //                 if (!exists) {
                //                   mockSizeAdds!.add(CatsModel(name: sizeName));

                //                   sizeCount.add(SizeCountSellerDto(
                //                       id: sizeId,
                //                       name: sizeName,
                //                       count: sizeCountController.text));

                //                   setState(() {});

                //                   sizeId = '';
                //                   sizeName = '';
                //                   sizeCountController.clear();
                //                 } else {
                //                   // Get.to(() => {})

                //                   sizeId = '';
                //                   sizeName = '';
                //                   sizeCountController.clear();
                //                   Get.snackbar('Ошибка', 'Данные уже имеется!',
                //                       backgroundColor: Colors.redAccent);
                //                 }
                //               } else {
                //                 Get.snackbar('Ошибка', 'Нет данных!',
                //                     backgroundColor: Colors.redAccent);
                //               }
                //             });
                //           },
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: AppColors.mainBackgroundPurpleColor,
                //                 borderRadius: BorderRadius.circular(8)),
                //             alignment: Alignment.center,
                //             width: double.infinity,
                //             height: 38,
                //             child: const Text(
                //               '+ Добавить размер',
                //               style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w700,
                //                   color: AppColors.mainPurpleColor),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),

                // if (filledCount == 3)
                //   SizedBox(
                //     height: 88,
                //     child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         // physics: const NeverScrollableScrollPhysics(),
                //         itemCount: sizeCount.length,
                //         itemBuilder: ((context, index) {
                //           return Container(
                //             padding: EdgeInsets.all(12),
                //             margin: EdgeInsets.all(5),
                //             alignment: Alignment.center,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(12),
                //                 color: AppColors.kBackgroundColor),
                //             height: 58,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Row(
                //                       children: [
                //                         Text(
                //                           'Размер: ',
                //                           style: const TextStyle(
                //                               fontSize: 14,
                //                               color: AppColors.kGray300,
                //                               fontWeight: FontWeight.w400),
                //                         ),
                //                         Text(
                //                           '${sizeCount[index].name}',
                //                           style: const TextStyle(
                //                               fontSize: 14,
                //                               fontWeight: FontWeight.w500),
                //                         ),
                //                       ],
                //                     ),
                //                     Row(
                //                       children: [
                //                         Text(
                //                           'Количество: ',
                //                           style: const TextStyle(
                //                               fontSize: 14,
                //                               color: AppColors.kGray300,
                //                               fontWeight: FontWeight.w400),
                //                         ),
                //                         Text(
                //                           '${sizeCount[index].count} шт',
                //                           style: const TextStyle(
                //                               fontSize: 14,
                //                               fontWeight: FontWeight.w500),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //                 InkWell(
                //                   onTap: (() {
                //                     sizeCount.removeAt(index);
                //                     setState(() {});
                //                   }),
                //                   child: Icon(
                //                     Icons.close,
                //                     color: Colors.red,
                //                   ),
                //                 )
                //               ],
                //             ),
                //           );
                //         })),
                //   ),

                // if (filledCount == 3) const SizedBox(height: 15),

                if (filledCount == 3)
                  FieldsProductRequest(
                    titleText: 'Укажите размер и количество',
                    controller: sizeCountController,
                    hintText: 'Выберите из списка',
                    hintColor: false,
                    star: true,
                    arrow: true,
                    onPressed: () {
                      List<SizeCountSellerDto> dataWidget = [];

                      for (var e in mockSizes!) {
                        // Найдём ранее сохранённое значение (если есть)
                        final existing = sizeCount.firstWhere(
                          (i) => i.id == e.id.toString(),
                          orElse: () => SizeCountSellerDto(
                            id: e.id.toString(),
                            name: e.name ?? '',
                            count: '0',
                          ),
                        );
                        dataWidget
                            .add(existing); // Используем сохранённый (или с 0)
                      }

                      showSellerSizeCountOptions(
                        context,
                        'Укажите размер и количество',
                        dataWidget,
                        (List<SizeCountSellerDto> values) {
                          // Обновим sizeCount, но не обнуляем
                          for (var newItem in values) {
                            final index =
                                sizeCount.indexWhere((i) => i.id == newItem.id);
                            if (index != -1) {
                              // Обновим count
                              sizeCount[index] = newItem;
                            } else {
                              // Добавим, если новое
                              sizeCount.add(newItem);
                            }
                          }

                          // Обновим отображаемый текст
                          String sizeNames =
                              sizeCount.map((e) => e.name).join(', ');
                          sizeCountController.text = sizeNames;

                          setState(() {});
                        },
                      );
                    },
                  ),

                // if (filledCount == 3)
                //   SizedBox(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           'Цвет',
                //           style: TextStyle(
                //               fontSize: 16, fontWeight: FontWeight.w700),
                //         ),
                //         const SizedBox(height: 10),
                //         GestureDetector(
                //           onTap: () {
                //             showSellerCatsOptions(
                //                 context, 'Добавить цвет', mockColors!, (value) {
                //               final CatsModel catsModel = value;

                //               print(catsModel.name);

                //               final colorId = catsModel.id.toString();
                //               final colorName = catsModel.name ?? 'Пустое';

                //               colorCountController.text = catsModel.name!;

                //               if (colorCountController.text.isNotEmpty) {
                //                 bool exists = false;

                //                 //  Cats? sizeCountLast;
                //                 // if (optomCount.isNotEmpty) {

                //                 // sizeCountLast = mockSizeAdds!.isEmpty ? mockSizeAdds!.last : null;
                //                 for (var element in checkColors!) {
                //                   if (element.name == colorName) {
                //                     exists = true;
                //                     setState(() {});
                //                   }
                //                   continue;
                //                 }
                //                 //   }

                //                 if (!exists) {
                //                   checkColors!.add(CatsModel(name: colorName));

                //                   colorCount.add(ColorCountSellerDto(
                //                       color_id: colorId,
                //                       name: colorName,
                //                       count: colorCountController.text));

                //                   setState(() {});

                //                   colorCountController.clear();
                //                 } else {
                //                   colorCountController.clear();
                //                   Get.snackbar('Ошибка', 'Данные уже имеется!',
                //                       backgroundColor: Colors.redAccent);
                //                 }
                //               } else {
                //                 Get.snackbar('Ошибка', 'Нет данных!',
                //                     backgroundColor: Colors.redAccent);
                //               }

                //               setState(() {});
                //             });
                //           },
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 color: AppColors.mainBackgroundPurpleColor,
                //                 borderRadius: BorderRadius.circular(8)),
                //             alignment: Alignment.center,
                //             width: double.infinity,
                //             height: 38,
                //             child: const Text(
                //               '+ Добавить цвет',
                //               style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w700,
                //                   color: AppColors.mainPurpleColor),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),

                if (filledCount == 3)
                  FieldsProductRequest(
                    titleText: 'Укажите цвета',
                    controller: colorCountController,
                    hintText: 'Выберите из списка',
                    hintColor: false,
                    star: true,
                    arrow: true,
                    onPressed: () {
                      List<CatsModel> dataWidget = [];

                      for (var e in mockColors!) {
                        final isSelected = colorCount
                            .any((i) => i.color_id == e.id.toString());

                        dataWidget.add(CatsModel(
                          id: e.id,
                          name: e.name,
                          isSelect: isSelected,
                        ));
                      }
                      showSellerCharacteristicsOptions(
                        context,
                        'Укажите цвета',
                        dataWidget,
                        (List<CatsModel> values) {
                          for (var e in values) {
                            final colorId = e.id.toString();
                            final colorName = e.name ?? 'Пустое';

                            // Если уже есть — обновить, если нет — добавить
                            final index = colorCount.indexWhere(
                                (element) => element.color_id == colorId);
                            if (index != -1) {
                              colorCount[index] = ColorCountSellerDto(
                                color_id: colorId,
                                name: colorName,
                                count: colorCount[index]
                                    .count, // сохраняем старый count
                              );
                            } else {
                              colorCount.add(ColorCountSellerDto(
                                color_id: colorId,
                                name: colorName,
                                count: '0',
                              ));
                            }

                            // Обновляем checkColors аналогично
                            final exists =
                                checkColors!.any((c) => c.name == colorName);
                            if (!exists) {
                              checkColors!.add(CatsModel(name: colorName));
                            }
                          }

                          String colorNames =
                              values.map((e) => e.name ?? 'Пустое').join(', ');
                          colorCountController.text = colorNames;
                          setState(() {});

                          // Очистим, если нужно полностью перезаписать
                          // checkColors?.clear();
                          // colorCount.clear();

                          // for (var e in values) {
                          //   final colorId = e.id.toString();
                          //   final colorName = e.name ?? 'Пустое';

                          //   // Проверка, что уже не добавлен
                          //   final alreadyExists = checkColors!
                          //       .any((element) => element.name == colorName);

                          //   if (!alreadyExists) {
                          //     checkColors!.add(CatsModel(name: colorName));

                          //     colorCount.add(ColorCountSellerDto(
                          //       color_id: colorId,
                          //       name: colorName,
                          //       count: '0',
                          //     ));
                          //   } else {
                          //     Get.snackbar('Ошибка', '$colorName уже добавлен!',
                          //         backgroundColor: Colors.redAccent);
                          //   }
                          // }
                        },
                      );
                    },
                  ),

                // if (filledCount == 3) SizedBox(height: 5),

                // if (filledCount == 3)
                //   SizedBox(
                //     height: 62,
                //     child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         // physics: const NeverScrollableScrollPhysics(),
                //         itemCount: colorCount.length,
                //         itemBuilder: ((context, index) {
                //           return Container(
                //             padding: EdgeInsets.all(8),
                //             margin: EdgeInsets.all(5),
                //             alignment: Alignment.topCenter,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(12),
                //                 color: AppColors.kBackgroundColor),
                //             height: 62,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(top: 10.0),
                //                   child: Text(
                //                     '${colorCount[index].name}',
                //                     style: const TextStyle(
                //                         fontSize: 14,
                //                         fontWeight: FontWeight.w500),
                //                   ),
                //                 ),
                //                 SizedBox(width: 10),
                //                 InkWell(
                //                   onTap: (() {
                //                     colorCount.removeAt(index);
                //                     setState(() {});
                //                   }),
                //                   child: Icon(
                //                     Icons.close,
                //                     color: Colors.red,
                //                   ),
                //                 )
                //               ],
                //             ),
                //           );
                //         })),
                //   ),

                // if (filledCount == 2)
                //   FieldsProductRequest(
                //     titleText: 'Цвет ',
                //     hintText: colors!.name.toString(),
                //     hintColor: colors!.id != 0 ? true : false,
                //     star: true,
                //     arrow: true,
                //     onPressed: () async {
                //       final data = await Get.to(const ColorsSellerPage());
                //       if (data != null) {
                //         final CatsModel cat = data;
                //         setState(() {});
                //         colors = cat;
                //       }
                //     },
                //   ),

                if (filledCount == 3)
                  SizedBox(
                    height: characteristics!.length * 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   'Характиристика',
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.w700),
                        // ),
                        // const SizedBox(height: 10),
                        // GestureDetector(
                        //   onTap: () {
                        //     showSellerCharacteristicsOptions(context,
                        //         'Добавить характеристику', subCharacteristics,
                        //         (SizeCountSellerDto value) {
                        //       {
                        //         if (subCharacteristicsValueLast != null &&
                        //             characteristicsValuelast != null) {
                        //           bool exists = false;

                        //           for (int index = 0;
                        //               index < characteristicsValue!.length;
                        //               index++) {
                        //             if (characteristicsValue![index].key ==
                        //                 characteristicsValuelast!.key) {
                        //               if (subCharacteristicsValue![index]
                        //                       .value ==
                        //                   subCharacteristicsValueLast!
                        //                       .value) {
                        //                 exists = true;
                        //                 setState(() {});
                        //               }
                        //             }
                        //             continue;
                        //           }

                        //           if (!exists) {
                        //             characteristicsValue!.add(
                        //                 CharacteristicsModel(
                        //                     id: characteristicsValuelast!.id!,
                        //                     key: characteristicsValuelast!
                        //                         .key));
                        //             subCharacteristicsValue!.add(
                        //                 CharacteristicsModel(
                        //                     id: subCharacteristicsValueLast!
                        //                         .id!,
                        //                     value:
                        //                         subCharacteristicsValueLast!
                        //                             .value));

                        //             setState(() {});
                        //           } else {
                        //             // Get.to(() => {})
                        //             Get.snackbar(
                        //                 'Ошибка', 'Данные уже имеется!',
                        //                 backgroundColor: Colors.redAccent);
                        //           }
                        //         } else {
                        //           Get.snackbar('Ошибка', 'Нет данных!',
                        //               backgroundColor: Colors.redAccent);
                        //         }
                        //       }
                        //     });
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: AppColors.mainBackgroundPurpleColor,
                        //         borderRadius: BorderRadius.circular(8)),
                        //     alignment: Alignment.center,
                        //     width: double.infinity,
                        //     height: 38,
                        //     child: const Text(
                        //       '+ Добавить',
                        //       style: TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w700,
                        //           color: AppColors.mainPurpleColor),
                        //     ),
                        //   ),
                        // ),

                        Flexible(
                          child: ListView.builder(
                            shrinkWrap:
                                true, // 🔑 делает ListView высотой по содержимому
                            physics:
                                const NeverScrollableScrollPhysics(), // 🔑 запретить прокрутку внутри
                            itemCount: characteristics?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = characteristics![index];
                              final matched = subCharacteristicsValue
                                  ?.where((e) => e.mainId == item.id)
                                  .toList();
                              final matchedItem =
                                  matched != null && matched.isNotEmpty
                                      ? matched.first
                                      : null;
                              return FieldsProductRequest(
                                titleText: item.key ?? '',
                                hintText:
                                    matchedItem?.value ?? 'Выберите из списка',
                                hintColor:
                                    matchedItem?.value != null ? true : false,
                                star: true,
                                arrow: true,
                                onPressed: () async {
                                  final subIndexCharacteristics =
                                      await BlocProvider.of<
                                                  CharacteristicSellerCubit>(
                                              context)
                                          .subCharacteristic(
                                              id: item.id.toString());

                                  showSellerListCharacteristicsOptions(
                                      context,
                                      item.key ?? 'Добавить характеристику',
                                      'params',
                                      subIndexCharacteristics!,
                                      (CharacteristicsModel value) {
                                    {
                                      // characteristicsValuelast =
                                      //     CharacteristicsModel(
                                      //         id: item.id,
                                      //         key: item.key,
                                      //         value: item.value);

                                      // subCharacteristicsValueLast =
                                      //     CharacteristicsModel(
                                      //         id: value.id,
                                      //         mainId: item.id,
                                      //         key: value.key,
                                      //         value: value.value);
                                      // if (subCharacteristicsValueLast != null &&
                                      //     characteristicsValuelast != null) {
                                      //   bool exists = false;

                                      //   for (int index = 0;
                                      //       index <
                                      //           characteristicsValue!.length;
                                      //       index++) {
                                      //     if (characteristicsValue![index]
                                      //             .key ==
                                      //         characteristicsValuelast!.key) {
                                      //       if (subCharacteristicsValue![index]
                                      //               .value ==
                                      //           subCharacteristicsValueLast!
                                      //               .value) {
                                      //         exists = true;
                                      //         setState(() {});
                                      //       }
                                      //     }
                                      //     continue;
                                      //   }

                                      //   if (!exists) {
                                      //     characteristicsValue!.add(
                                      //         CharacteristicsModel(
                                      //             id: characteristicsValuelast!
                                      //                 .id!,
                                      //             key: characteristicsValuelast!
                                      //                 .key));
                                      //     subCharacteristicsValue!.add(
                                      //         CharacteristicsModel(
                                      //             id: subCharacteristicsValueLast!
                                      //                 .id!,
                                      //             mainId: item.id,
                                      //             value:
                                      //                 subCharacteristicsValueLast!
                                      //                     .value));

                                      //     setState(() {});
                                      //   } else {
                                      //     // Get.to(() => {})
                                      //     Get.snackbar(
                                      //         'Ошибка', 'Данные уже имеется!',
                                      //         backgroundColor:
                                      //             Colors.redAccent);
                                      //   }
                                      // } else {
                                      //   Get.snackbar('Ошибка', 'Нет данных!',
                                      //       backgroundColor: Colors.redAccent);
                                      // }

                                      final newCharacteristic =
                                          CharacteristicsModel(
                                        id: item.id,
                                        key: item.key,
                                        value: item.value,
                                      );

                                      final newSubCharacteristic =
                                          CharacteristicsModel(
                                        id: value.id,
                                        mainId: item.id,
                                        key: value.key,
                                        value: value.value,
                                      );

                                      characteristicsValue!
                                          .removeWhere((e) => e.id == item.id);
                                      subCharacteristicsValue!.removeWhere(
                                          (e) => e.mainId == item.id);

                                      characteristicsValue!
                                          .add(newCharacteristic);
                                      subCharacteristicsValue!
                                          .add(newSubCharacteristic);

                                      setState(() {});
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Expanded(
                        //                 child: Container(
                        //                   alignment: Alignment.centerLeft,
                        //                   margin:
                        //                       const EdgeInsets.only(right: 10),
                        //                   padding: const EdgeInsets.symmetric(
                        //                       horizontal: 10),
                        //                   decoration: BoxDecoration(
                        //                       color: Colors.white,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8)),
                        //                   // width: 111,
                        //                   height: 38,
                        //                   child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         Text(
                        //                           characteristicName == ''
                        //                               ? 'Параметр'
                        //                               : characteristicName,
                        //                           style: const TextStyle(
                        //                               fontSize: 12,
                        //                               fontWeight:
                        //                                   FontWeight.w400),
                        //                         ),
                        //                         PopupMenuButton(
                        //                           onSelected: (value) async {
                        //                             characteristicsValuelast =
                        //                                 CharacteristicsModel(
                        //                                     id: value.id,
                        //                                     key: value.key);
                        //                             //sizeId = value.id.toString();
                        //                             characteristicId =
                        //                                 value.id.toString();
                        //                             characteristicName =
                        //                                 value.key ?? 'Пустое';
                        //                             subCharacteristics =
                        //                                 await BlocProvider.of<
                        //                                             CharacteristicSellerCubit>(
                        //                                         context)
                        //                                     .subCharacteristic(
                        //                                         id: value.id
                        //                                             .toString());
                        //                             setState(() {});
                        //                           },
                        //                           shape:
                        //                               const RoundedRectangleBorder(
                        //                             borderRadius:
                        //                                 BorderRadius.all(
                        //                               Radius.circular(15.0),
                        //                             ),
                        //                           ),
                        //                           icon: SvgPicture.asset(
                        //                               'assets/icons/dropdown.svg'),
                        //                           position:
                        //                               PopupMenuPosition.under,
                        //                           offset: const Offset(0, 0),
                        //                           itemBuilder: (
                        //                             BuildContext bc,
                        //                           ) {
                        //                             return characteristics!
                        //                                 .map<PopupMenuItem>(
                        //                                     (e) {
                        //                               return PopupMenuItem(
                        //                                 value: e,
                        //                                 child: Text(
                        //                                   e.key ?? 'Пустое',
                        //                                   style:
                        //                                       const TextStyle(
                        //                                     color: Colors.black,
                        //                                   ),
                        //                                 ),
                        //                               );
                        //                             }).toList();
                        //                           },
                        //                         )
                        //                       ]),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           const SizedBox(
                        //             height: 5,
                        //           ),
                        //           Row(
                        //             children: [
                        //               Expanded(
                        //                 child: Container(
                        //                   alignment: Alignment.centerLeft,
                        //                   margin:
                        //                       const EdgeInsets.only(right: 10),
                        //                   padding: const EdgeInsets.symmetric(
                        //                       horizontal: 10),
                        //                   decoration: BoxDecoration(
                        //                       color: Colors.white,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8)),
                        //                   // width: 111,
                        //                   height: 38,
                        //                   child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         Text(
                        //                           subCharacteristicName == ''
                        //                               ? 'Значение'
                        //                               : subCharacteristicName,
                        //                           style: const TextStyle(
                        //                               fontSize: 12,
                        //                               fontWeight:
                        //                                   FontWeight.w400),
                        //                         ),
                        //                         PopupMenuButton(
                        //                           onSelected: (value) {
                        //                             subCharacteristicsValueLast =
                        //                                 CharacteristicsModel(
                        //                                     id: value.id,
                        //                                     value: value.value);

                        //                             // subCharacteristicsValue!.add(value as Characteristics);
                        //                             //sizeId = value.id.toString();
                        //                             subCharacteristicId =
                        //                                 value.id.toString();
                        //                             subCharacteristicName =
                        //                                 value.value ?? 'Пустое';
                        //                             setState(() {});
                        //                           },
                        //                           shape:
                        //                               const RoundedRectangleBorder(
                        //                             borderRadius:
                        //                                 BorderRadius.all(
                        //                               Radius.circular(15.0),
                        //                             ),
                        //                           ),
                        //                           icon: SvgPicture.asset(
                        //                               'assets/icons/dropdown.svg'),
                        //                           position:
                        //                               PopupMenuPosition.under,
                        //                           offset: const Offset(0, 0),
                        //                           itemBuilder: (
                        //                             BuildContext bc,
                        //                           ) {
                        //                             return subCharacteristics!
                        //                                 .map<PopupMenuItem>(
                        //                                     (e) {
                        //                               return PopupMenuItem(
                        //                                 value: e,
                        //                                 child: Text(
                        //                                   e.value ?? 'Пустое',
                        //                                   style:
                        //                                       const TextStyle(
                        //                                     color: Colors.black,
                        //                                   ),
                        //                                 ),
                        //                               );
                        //                             }).toList();
                        //                           },
                        //                         )
                        //                       ]),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                // if (filledCount == 3) const SizedBox(height: 28),
                // if (filledCount == 3)
                //   SizedBox(
                //     height:
                //         (120 * (characteristicsValue?.length ?? 0)).toDouble(),
                //     width: double.infinity,
                //     child: ListView.builder(
                //         scrollDirection: Axis.vertical,
                //         // physics: const NeverScrollableScrollPhysics(),
                //         itemCount: characteristicsValue?.length ?? 0,
                //         itemBuilder: ((context, index) {
                //           return SizedBox(
                //             height: 120,
                //             width: double.infinity,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     Flexible(
                //                       child: FieldsProductRequest(
                //                         titleText:
                //                             '${characteristics?[index].key}',
                //                         hintText:
                //                             '${subCharacteristics?[index].value}',
                //                         star: false,
                //                         readOnly: true,
                //                         arrow: true,
                //                         hintColor: true,
                //                         controller: countController,
                //                         textInputNumber: true,
                //                       ),
                //                     ),
                //                     InkWell(
                //                       onTap: (() {
                //                         characteristicsValue?.removeAt(index);
                //                         subCharacteristics?.removeAt(index);
                //                         setState(() {});
                //                       }),
                //                       child: Icon(
                //                         Icons.delete_forever,
                //                         color: Colors.black,
                //                         size: 30,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 SizedBox(height: 10),
                //               ],
                //             ),
                //           );
                //         })),
                //   ),

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
                if (filledCount == 4)
                  const Text(
                    'Прикрепите фото',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                if (filledCount == 4)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (filledCount == 4)
                          const Text(
                            'Формат - jpg, png',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.kGray900),
                          ),
                        if (filledCount == 4)
                          const SizedBox(
                            height: 10,
                          ),
                        if (filledCount == 4)
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: "Изменить фото",
                                        middleText: '',
                                        textConfirm: 'Камера',
                                        textCancel: 'Фото',
                                        titlePadding:
                                            const EdgeInsets.only(top: 40),
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
                                    height: 92,
                                    width: 92,
                                    decoration: BoxDecoration(
                                        color: AppColors.kGray2,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          color: change == false
                                              ? AppColors.mainPurpleColor
                                              : AppColors.kGray300,
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(width: 8),
                              _image.isNotEmpty
                                  ? SizedBox(
                                      width: 240,
                                      height: 92,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _image.length,
                                        itemExtent:
                                            100, // Fixed width for each item
                                        physics:
                                            const ClampingScrollPhysics(), // Better control than Bouncing
                                        padding: EdgeInsets.zero,
                                        shrinkWrap:
                                            false, // Important for scrolling
                                        primary:
                                            false, // Приятная физика прокрутки
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8,
                                            ), // Отступ между изображениями
                                            child: Stack(
                                              clipBehavior: Clip
                                                  .none, // Позволяет иконке выходить за границы
                                              children: [
                                                // Контейнер с изображением
                                                Container(
                                                  height: 92,
                                                  width: 92,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.grey[200],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.file(
                                                      File(_image[index]!.path),
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Container(
                                                        color: Colors.grey[200],
                                                        child: const Icon(
                                                            Icons.broken_image,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                // Кнопка удаления
                                                Positioned(
                                                  top: 35,
                                                  right: 35,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _image.removeAt(index);
                                                      setState(() {
                                                        _image;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                            blurRadius: 4,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : SizedBox()
                              // ? SizedBox(
                              //     height: 100,
                              //     width: 1000,
                              //     child: ListView.builder(
                              //       shrinkWrap: true,
                              //       scrollDirection: Axis.horizontal,
                              //       itemCount: _image.length,
                              //       itemBuilder: (context, index) {
                              //         return Stack(children: [
                              //           Container(
                              //             height: 92,
                              //             width: 92,
                              //             child: Image.file(
                              //               File(_image[index]!.path),
                              //             ),
                              //           ),
                              //           Positioned(
                              //             top: 35,
                              //             right: 35,
                              //             child: GestureDetector(
                              //               onTap: () {
                              //                 _image.removeAt(index);
                              //                 setState(() {
                              //                   _image;
                              //                 });
                              //               },
                              //               child: const Icon(
                              //                 Icons.delete_outline_outlined,
                              //                 color: Colors.grey,
                              //               ),
                              //             ),
                              //           ),
                              //         ]);
                              //       },
                              //     ),
                              //   )
                              // : Container(),
                            ],
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (filledCount == 4)
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
                if (filledCount == 4)
                  const SizedBox(
                    height: 10,
                  ),
                if (filledCount == 4)
                  const Text(
                    'Прикрепите видео',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                if (filledCount == 4)
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
                        // if (_video != null &&
                        //     _controller != null &&
                        //     _controller!.value.isInitialized)
                        //   Padding(
                        //     padding: const EdgeInsets.only(top: 10),
                        //     child: Center(
                        //       child: SizedBox(
                        //         height: 200,
                        //         child: AspectRatio(
                        //           aspectRatio: _controller!.value.aspectRatio,
                        //           child: ClipRRect(
                        //               borderRadius: BorderRadius.circular(12),
                        //               child: VideoPlayer(_controller!)),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                    title: "Изменить видео",
                                    middleText: '',
                                    textConfirm: 'Камера',
                                    textCancel: 'Видео',
                                    titlePadding:
                                        const EdgeInsets.only(top: 40),
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
                                height: 92,
                                width: 92,
                                decoration: BoxDecoration(
                                    color: AppColors.kGray2,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(Assets.icons.video.path,
                                        color: AppColors.mainPurpleColor),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            if (_video != null &&
                                _controller != null &&
                                _controller!.value.isInitialized)
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                ), // Отступ между изображениями
                                child: Container(
                                  height: 92,
                                  width: 92,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[200],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: AspectRatio(
                                      aspectRatio:
                                          _controller!.value.aspectRatio,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: VideoPlayer(_controller!)),
                                    ),
                                  ),
                                ),
                              )
                          ],
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
                if (filledCount == 4)
                  const SizedBox(
                    height: 20,
                  ),
                // const FieldsProductRequest(
                //   titleText: 'Магазин ',
                //   hintText: 'Магазин',
                //   star: false,
                //   arrow: false,
                // ),
                if (filledCount == 4)
                  const SizedBox(
                    height: 80,
                  ),

                if (filledCount == 5)
                  Container(
                    width: 166,
                    constraints: BoxConstraints(
                      minHeight: 60,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.kGray2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Выберите схему продаж',
                          style: AppTextStyles.counterSellerProfileTextStyle,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Круглый чекбокс с анимацией
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () => toggleCheckboxFBS(!isCheckedFBS),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: !isCheckedFBS
                                          ? AppColors.mainPurpleColor
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: !isCheckedFBS
                                            ? AppColors.mainPurpleColor
                                            : Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: !isCheckedFBS
                                        ? const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Текст с переносами
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: AppColors.kLightBlackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'FBS (realFBS)',
                                      style: TextStyle(
                                          fontWeight:
                                              FontWeight.w600), // жирный
                                    ),
                                    TextSpan(
                                      text:
                                          ' — это модель работы, при которой:\n'
                                          '• Продавец сам хранит товары у себя (не на складе маркетплейса)\n'
                                          '• Продавец сам комплектует заказ\n'
                                          '• Продавец самостоятельно доставляет товар покупателю',
                                    ),
                                  ],
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Круглый чекбокс с анимацией
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () => toggleCheckboxFBS(!isCheckedFBS),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isCheckedFBS
                                          ? AppColors.mainPurpleColor
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isCheckedFBS
                                            ? AppColors.mainPurpleColor
                                            : Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: isCheckedFBS
                                        ? const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: AppColors.kLightBlackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'FBS (Fulfillment by Seller)',
                                      style: TextStyle(
                                          fontWeight:
                                              FontWeight.w600), // жирный
                                    ),
                                    TextSpan(
                                      text:
                                          ' — это модель работы, при которой:\n'
                                          '• Продавец сам хранит товары у себя (не на складе маркетплейса)\n'
                                          '• Продавец сам комплектует заказ\n'
                                          '• Продавец передаёт заказ логистическому партнёру маркетплейса, который доставляет товар покупателю',
                                    ),
                                  ],
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (filledCount == 5) const SizedBox(height: 10),

                if (filledCount == 5 && isCheckedFBS)
                  FieldsProductRequest(
                    titleText: 'Ширина, мм ',
                    hintText: 'Введите ширину',
                    star: true,
                    arrow: false,
                    controller: widthController,
                    textInputNumber: true,
                  ),
                if (filledCount == 5 && isCheckedFBS)
                  FieldsProductRequest(
                    titleText: 'Высота, мм ',
                    hintText: 'Введите высоту',
                    star: true,
                    arrow: false,
                    controller: heightController,
                    textInputNumber: true,
                  ),
                if (filledCount == 5 && isCheckedFBS)
                  FieldsProductRequest(
                    titleText: 'Глубина, мм ',
                    hintText: 'Введите глубину',
                    star: true,
                    arrow: false,
                    controller: deepController,
                    textInputNumber: true,
                  ),
                if (filledCount == 5 && isCheckedFBS)
                  FieldsProductRequest(
                    titleText: 'Вес, г ',
                    hintText: 'Введите вес',
                    star: true,
                    arrow: false,
                    controller: massaController,
                    textInputNumber: true,
                  ),
                if (filledCount == 5) const SizedBox(height: 60),

                // if (filledCount == 6)
                //   Text(
                //     'География продаж:',
                //     style: AppTextStyles.defaultButtonTextStyle
                //         .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                //   ),
                if (filledCount == 6) SizedBox(height: 10),
                if (filledCount == 6)
                  FieldsProductRequest(
                    titleText: 'География продаж:',
                    hintText: _locationSelect,
                    star: false,
                    arrow: true,
                    hintColor: false,
                    onPressed: () {
                      showSellerCatsOptions(
                          context, 'Выбор локации', _locations, (value) {
                        final CatsModel data = value;

                        if (data.name == 'Регион') {
                          _regionsArray();
                        }
                        if (data.name == 'Город/населенный пункт') {
                          print('ok');
                          _citiesArray('RU');
                        }

                        setState(() {
                          _locationSelect = data.name ?? 'Не выбрано';
                        });
                      });
                    },
                    controller: massaController,
                    textInputNumber: false,
                  ),
                if (filledCount == 6 &&
                    (_locationSelect == 'Регион' ||
                        _locationSelect == 'Город/населенный пункт' ||
                        _locationSelect == 'Моя локация'))
                  FieldsProductRequest(
                    titleText: '$_locationSeller',
                    hintText: '$_locationSeller',
                    star: false,
                    arrow: true,
                    hintColor: false,
                    onPressed: () {
                      if (_locationSelect == 'Регион' ||
                          _locationSelect == 'Город/населенный пункт') {
                        showSellerCatsOptions(
                            context, _locationSelect, _regions, (value) {
                          setState(() {
                            cats = value;

                            _locationSeller = cats?.name ?? '';
                          });
                        });
                      } else {
                        Get.to(MapSellerPickerPage(
                          lat: 43.238949,
                          long: 76.889709,
                        ));
                      }
                    },
                    controller: massaController,
                    textInputNumber: false,
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
            filledCount = filledCount > 0 ? filledCount + 1 : 0;

            if (filledCount == 1) {
              title = 'Основная информация';
            }
            if (filledCount == 2) {
              title = 'Способ реализации';
            }
            if (filledCount == 3) {
              title = 'Описание';
            }
            if (filledCount == 4) {
              title = 'Фото и видео';
            }
            if (filledCount == 5) {
              title = 'Условия продажи';
            }
            if (filledCount == 6) {
              title = 'Локация';
            }
            setState(() {});

            if (filledCount == 7) {
              List<int> subIds = [];

              if (subCharacteristicsValue?.isNotEmpty ?? false) {
                for (var e in subCharacteristicsValue!) {
                  subIds.add(e.id!.toInt());
                }
              }

              isChangeState = true;
              if (_image.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  priceController.text.isNotEmpty &&
                  countController.text.isNotEmpty &&
                  // brands?.id != 0 &&
                  colors?.id != 0) {
                if (fulfillment == 'fbs') {
                  if (widthController.text.isEmpty ||
                      heightController.text.isEmpty ||
                      deepController.text.isEmpty ||
                      massaController.text.isEmpty) {
                    Get.snackbar(
                        "Ошибка Доставка", "Заполните данные для доставки",
                        backgroundColor: Colors.orangeAccent);
                    return;
                  }
                }

                await BlocProvider.of<ProductSellerCubit>(context).store(
                    priceController.text,
                    countController.text,
                    compoundController.text,
                    cats!.id.toString(),
                    subCats?.id == null ? null : subCats?.id.toString(),
                    brands?.id == null ? null : brands?.id.toString(),
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
                    fulfillment,
                    subIds,
                    _video != null ? _video!.path : null);
              } else {
                Get.snackbar("Ошибка", "Заполните данные",
                    backgroundColor: Colors.orangeAccent);
              }
            }
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mainPurpleColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Далее',
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
  final CatsModel? cats;
  final bool? textInputNumber;
  final bool readOnly;
  final void Function()? onPressed;
  final int? maxLines; // добавили

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
    this.readOnly = false,
    this.maxLines, // добавили
  }) : super(key: key);

  @override
  State<FieldsProductRequest> createState() => _FieldsProductRequestState();
}

class _FieldsProductRequestState extends State<FieldsProductRequest> {
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
              widget.star == true
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
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
                color: AppColors.kGray2,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: TextField(
                controller: widget.controller,
                readOnly:
                    (widget.hintColor == false || widget.hintColor == null)
                        ? widget.readOnly
                        : true,
                keyboardType: (widget.maxLines != null && widget.maxLines! > 1)
                    ? TextInputType.multiline
                    : ((widget.textInputNumber == false ||
                            widget.textInputNumber == null)
                        ? TextInputType.text
                        : const TextInputType.numberWithOptions(
                            signed: true, decimal: true)),
                maxLines: widget.maxLines ?? 1, // вот оно
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
                  ),
                  suffixIcon: widget.arrow == true
                      ? IconButton(
                          onPressed: widget.onPressed,
                          icon: SvgPicture.asset('assets/icons/back_menu.svg',
                              color: Colors.grey),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
