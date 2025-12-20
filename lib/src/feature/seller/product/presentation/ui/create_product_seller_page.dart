import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widget/app_switch.dart';
import 'package:haji_market/src/feature/app/widget/show_upload_media_pricker_widget.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
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
    as last_articul;
import 'package:haji_market/src/feature/seller/product/bloc/size_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/map_seller_picker.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/meta_state.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_list_characteristics_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_cats_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_characteristics_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_optom_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_seller_size_counts_widget.dart';
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
class CreateProductSellerPage extends StatefulWidget implements AutoRouteWrapper {
  final CatsModel? cat;
  final CatsModel? subCat;
  const CreateProductSellerPage({required this.cat, required this.subCat, super.key});

  @override
  State<CreateProductSellerPage> createState() => _CreateProductSellerPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductSellerCubit(productAdminRepository: ProductSellerRepository())..products(''),
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
  TextEditingController deepController = TextEditingController();
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

  final List<CatsModel> _locations = [
    CatsModel(id: 0, name: 'Не выбрано'),
    CatsModel(id: 1, name: 'Без ограничений'),
    CatsModel(id: 2, name: 'Вся Россия'),
    CatsModel(id: 3, name: 'Регион'),
    CatsModel(id: 4, name: 'Город/населенный пункт'),
    CatsModel(id: 5, name: 'Моя локация'),
  ];

  final List<CatsModel> _regions = [];

  void _regionsArray() async {
    final List<CountryModel> data = await BlocProvider.of<CountryCubit>(context).countryList();
    _regions.clear();

    for (int i = 0; i < data.length; i++) {
      _regions.add(CatsModel(id: data[i].id, name: data[i].name));
    }
  }

  void _citiesArray(String country) async {
    final List<CityModel> data = await BlocProvider.of<CityCubit>(context).citiesList(country);

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
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
                      width: 300,
                    ),
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
    characteristics = await BlocProvider.of<CharacteristicSellerCubit>(context).characteristic();

    if (!mounted) return;

    subCharacteristics = await BlocProvider.of<CharacteristicSellerCubit>(
      context,
    ).subCharacteristic();

    setState(() {});
  }

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг',
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
    filledCount = (filledCount < 7) ? filledCount + 1 : 0;

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
  }

  // Функция для уменьшения прогресса
  void decreaseProgress() {
    filledCount = filledCount > 0 ? filledCount - 1 : 0;

    if (filledCount > 0) {
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
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _removeVideo() async {
    await _disposeController();
    setState(() => _video = null);
  }

  void articul() async {
    await BlocProvider.of<last_articul.LastArticulSellerCubit>(context).getLastArticul().then((
      last,
    ) {
      articulController.text = last.toString();
    });
  }

  @override
  void initState() {
    articul();
    if (BlocProvider.of<MetaCubit>(context).state is! MetaStateLoaded) {
      BlocProvider.of<MetaCubit>(context).partners();
    }

    if (BlocProvider.of<BrandCubit>(context).state is! MetaStateLoaded) {
      BlocProvider.of<BrandCubit>(context).brands();
    }

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
      BlocProvider.of<CityCubit>(context).citiesCdek('RU');
    }

    _sizeArray();
    _colorArray();
    _charactisticsArray();

    for (final c in [
      nameController,
      articulController,
      descriptionController,
      priceController,
      compoundController,
      ndsController,
      pointsController,
      pointsBloggerController,
      countController,
    ]) {
      c.addListener(() => setState(() {}));
    }

    super.initState();
  }

  // --- helpers ---
  double? _toDouble(String s) => double.tryParse(s.replaceAll(',', '.'));
  int? _toInt(String s) => int.tryParse(s);

  // SKU (артикул)
  String? _validateSKU(String v) {
    if (v.isEmpty) return 'Укажите артикул';
    final ok = RegExp(r'^[A-Za-z0-9\-_]+$').hasMatch(v);
    return ok ? null : 'Допустимы буквы/цифры, «-» и «_»';
  }

  // Цена > 0
  String? _validatePrice(String v) {
    if (v.isEmpty) return 'Укажите цену';
    final d = _toDouble(v);
    if (d == null) return 'Некорректная цена';
    if (d <= 0) return 'Цена должна быть больше 0';
    return null;
  }

  // НДС 0..100
  String? _validatePercent(String v) {
    if (v.trim().isEmpty) return 'Укажите НДС';

    if (v == 'Не облагается') {
      return null;
    }
    // извлечь число вида 10, 10.5, 10,5 + допускаем пробелы и %
    final match = RegExp(r'^\s*([+-]?\d+(?:[.,]\d+)?)\s*%?\s*$').firstMatch(v);
    if (match == null) return 'Некорректный НДС';

    final numStr = match.group(1)!.replaceAll(',', '.'); // 10,5 -> 10.5
    final d = double.tryParse(numStr);
    if (d == null) return 'Некорректный НДС';
    if (d < 0 || d > 100) return 'НДС должен быть в диапазоне 0–100';

    return null;
  }

  // Целое ≥ 0
  String? _validateIntNonNeg(String v, {required String fieldName}) {
    if (v.isEmpty) return 'Укажите $fieldName';
    final i = _toInt(v);
    if (i == null) return 'Только целое число';
    if (i < 0) return '$fieldName не может быть отрицательным';
    return null;
  }

  // Количество ≥ 1
  String? _validateCount(String v) {
    if (v.isEmpty) return 'Укажите количество';
    final i = _toInt(v);
    if (i == null) return 'Только целое число';
    if (i < 1) return 'Количество должно быть не меньше 1';
    return null;
  }

  // --- твоя карта ошибок (оставляю те же ключи) ---
  Map<String, String?> fieldStep1Errors = {
    'cat': null,
    'sub_cat': null,
    'brand': null,
    'name': null,
    'articul': null,
    'description': null,
    'price': null,
    'compound': null,
    'nds': null,
    'point': null,
    'pointBlogger': null,
    'count': null,
  };

  Map<String, String?> fieldStep4Errors = {'image': null};

  Map<String, String?> fieldStep5Errors = {
    'width': null,
    'height': null,
    'deep': null,
    'massa': null,
  };

  // Валидируем и обновляем карту ошибок
  void _validateStep1Fields() {
    setState(() {
      fieldStep1Errors['cat'] = cats?.name == null ? 'Выберите категорию' : null;
      fieldStep1Errors['sub_cat'] = subCats?.name == null ? 'Выберите подкатегорию' : null;
      fieldStep1Errors['brand'] = brands?.name == null ? 'Выберите бренд' : null;
      fieldStep1Errors['name'] = nameController.text.trim().isEmpty
          ? 'Введите название товара'
          : null;

      fieldStep1Errors['articul'] = _validateSKU(articulController.text.trim());

      final desc = descriptionController.text.trim();
      fieldStep1Errors['description'] = desc.isEmpty
          ? 'Введите описание'
          : (desc.length < 10 ? 'Минимум 10 символов' : null);

      fieldStep1Errors['price'] = _validatePrice(priceController.text.trim());

      fieldStep1Errors['compound'] = _validatePrice(compoundController.text.trim());

      fieldStep1Errors['nds'] = _validatePercent(ndsController.text.trim());

      fieldStep1Errors['point'] = _validateIntNonNeg(
        pointsController.text.trim(),
        fieldName: 'бонусы',
      );

      fieldStep1Errors['pointBlogger'] = _validateIntNonNeg(
        pointsBloggerController.text.trim(),
        fieldName: 'бонусы блогера',
      );

      fieldStep1Errors['count'] = _validateCount(countController.text.trim());
    });
  }

  // Валидируем и обновляем карту ошибок
  void _validateStep4Fields() {
    setState(() {
      fieldStep4Errors['image'] = _image.isEmpty ? 'Прикрепите фото товара' : null;
    });
  }

  void _validateStep5Fields() {
    setState(() {
      fieldStep5Errors['width'] = _validateIntNonNeg(
        widthController.text.trim(),
        fieldName: 'ширину в мм',
      );
      fieldStep5Errors['height'] = _validateIntNonNeg(
        heightController.text.trim(),
        fieldName: 'высоту в мм',
      );
      fieldStep5Errors['deep'] = _validateIntNonNeg(
        deepController.text.trim(),
        fieldName: 'глубину в мм',
      );
      fieldStep5Errors['massa'] = _validateIntNonNeg(
        massaController.text.trim(),
        fieldName: 'вес в гр',
      );
    });
  }

  // true — если ошибок нет
  bool get isStep1Valid => fieldStep1Errors.values.every((e) => e == null);

  bool get isStep4Valid => fieldStep4Errors.values.every((e) => e == null);

  bool get isStep5Valid => fieldStep5Errors.values.every((e) => e == null);

  // Вызови при сабмите
  bool validateStep1AndSubmit() {
    _validateStep1Fields();
    return isStep1Valid;
  }

  bool validateStep4AndSubmit() {
    _validateStep4Fields();
    return isStep4Valid;
  }

  bool validateStep5AndSubmit() {
    _validateStep5Fields();
    return isStep5Valid;
  }

  // Порядок важности/фокуса при показе первой ошибки
  final _step1Order = const [
    'cat',
    'sub_cat',
    'brand',
    'name',
    'articul',
    'description',
    'price',
    'compound',
    'nds',
    'point',
    'pointBlogger',
    'count',
  ];

  final _step4Order = const ['image'];

  final _step5Order = const ['width', 'height', 'deep', 'massa'];

  /// Возвращает текст первой найденной ошибки или null
  String? _validateStep1Error() {
    // Актуализируем карту ошибок
    _validateStep1Fields();

    for (final key in _step1Order) {
      final msg = fieldStep1Errors[key];
      if (msg != null) return msg;
    }
    return null;
  }

  String? _validateStep4Error() {
    _validateStep4Fields();
    for (final key in _step4Order) {
      final msg = fieldStep4Errors[key];
      if (msg != null) return msg;
    }
    return null;
  }

  String? _validateStep5Error() {
    _validateStep5Fields();
    for (final key in _step5Order) {
      final msg = fieldStep5Errors[key];
      if (msg != null) return msg;
    }
    return null;
  }

  /// Показывает первую ошибку и возвращает false, если есть ошибки.
  /// true — если все поля валидны.
  bool _ensureStep1Valid() {
    final msg = _validateStep1Error();
    if (msg != null) {
      // Берём живой root-контекст, чтобы не ловить "deactivated widget's ancestor"
      final rootCtx = context.router.root.navigatorKey.currentContext ?? context;
      AppSnackBar.show(rootCtx, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  bool _ensureStep4Valid() {
    final msg = _validateStep4Error();
    if (msg != null) {
      final rootCtx = context.router.root.navigatorKey.currentContext ?? context;
      AppSnackBar.show(rootCtx, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  bool _ensureStep5Valid() {
    final msg = _validateStep5Error();
    if (msg != null) {
      final rootCtx = context.router.root.navigatorKey.currentContext ?? context;
      AppSnackBar.show(rootCtx, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  Future<void> _disposeController() async {
    try {
      await _controller?.pause();
      await _controller?.dispose();
    } catch (_) {}
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      extendBody: true,
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhite,
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text('Добавить товар', style: AppTextStyles.appBarTextStyle),
        leading: InkWell(
          onTap: () {
            decreaseProgress();
          },
          child: Icon(Icons.arrow_back),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  title,
                  style: AppTextStyles.size16Weight400.copyWith(color: Color(0xff808080)),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: segmentHeight,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: totalSegments,
                    separatorBuilder: (_, _) => SizedBox(width: segmentSpacing),
                    itemBuilder: (context, index) {
                      bool isFilled = index < filledCount;
                      return Container(
                        width:
                            (MediaQuery.of(context).size.width -
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
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<ProductSellerCubit, ProductAdminState>(
        listener: (context, state) {
          if (state is StoreState) {
            context.router.push(SuccessSellerProductStoreRoute());
            // int count = 0;
            // Navigator.of(context).popUntil((_) => count++ >= 2);
            // isChangeState = false;
          }
        },
        builder: (context, state) {
          if (state is LoadedState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: 8),
                  if (filledCount == 1)
                    FieldsProductRequest(
                      titleText: 'Категория и тип',
                      hintText: cats?.name ?? 'Выберите категорию',
                      hintColor: cats == null ? false : true,
                      star: true,
                      arrow: true,
                      errorText: fieldStep1Errors['cat'],
                      onPressed: () async {
                        if (_cats.isEmpty) {
                          _cats = await BlocProvider.of<CatsCubit>(context).catsList();
                        }

                        if (!context.mounted) return;

                        showSellerCatsOptions(context, 'Категория и тип', _cats, true, (value) {
                          setState(() {
                            cats = value;
                          });
                        });
                      },
                    ),

                  if (filledCount == 1)
                    FieldsProductRequest(
                      titleText: 'Подкатегория',
                      hintText: subCats?.name ?? 'Выберите подкатегорию',
                      hintColor: subCats == null ? false : true,
                      star: true,
                      arrow: true,
                      errorText: fieldStep1Errors['sub_cat'],
                      onPressed: () async {
                        if (_subCats.isEmpty) {
                          _subCats = await BlocProvider.of<SubCatsCubit>(context).subCatsList();
                        }

                        if (!context.mounted) return;

                        showSellerCatsOptions(context, 'Подкатегория', _subCats, true, (value) {
                          setState(() {
                            subCats = value;
                          });
                        });
                      },
                    ),
                  if (filledCount == 1)
                    FieldsProductRequest(
                      titleText: 'Бренд',
                      hintText: brands?.name ?? 'Выберите бренд',
                      hintColor: brands == null ? false : true,
                      star: true,
                      arrow: true,
                      errorText: fieldStep1Errors['brand'],
                      onPressed: () async {
                        if (_brands.isEmpty) {
                          _brands = await BlocProvider.of<BrandCubit>(context).brandsList();
                        }

                        if (!context.mounted) return;

                        showSellerCatsOptions(context, 'Бренд', _brands, true, (value) {
                          setState(() {
                            brands = value;
                          });
                        });
                      },
                    ),
                  if (filledCount == 1)
                    FieldsProductRequest(
                      titleText: 'Название товара ',
                      hintText: 'Введите название товара',
                      star: false,
                      arrow: false,
                      controller: nameController,
                      errorText: fieldStep1Errors['name'],
                    ),
                  if (filledCount == 1)
                    BlocListener<
                      last_articul.LastArticulSellerCubit,
                      last_articul.LastArticulSellerState
                    >(
                      listener: (context, stateArticul) {
                        if (stateArticul is last_articul.LoadedState) {
                          articulController.text = getFormattedArticle(
                            stateArticul.articul.toString(),
                          );
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
                  if (filledCount == 1)
                    FieldsProductRequest(
                      titleText: 'Описание товара',
                      hintText: 'Расскажите подробнее о товаре',
                      star: true,
                      arrow: false,
                      controller: descriptionController,
                      maxLines: 4,
                      errorText: fieldStep1Errors['description'],
                    ),
                  if (filledCount == 1)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FieldsProductRequest(
                            titleText: 'Цена товара ',
                            hintText: 'Введите цену',
                            star: false,
                            arrow: false,
                            controller: priceController,
                            textInputNumber: true,
                            errorText: fieldStep1Errors['price'],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 96,
                          height: 52,
                          margin: EdgeInsets.only(top: 14),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffEAECED),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(currencyName),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    final List<CatsModel> currency = [
                                      CatsModel(id: 0, name: 'Российский рубль (RUB)'),
                                      CatsModel(id: 1, name: 'Казахстанский тенге (KZT)'),
                                      CatsModel(id: 2, name: 'Белорусский рубль (BYN)'),
                                    ];
                                    showSellerCatsOptions(context, 'Валюта', currency, false, (
                                      value,
                                    ) {
                                      final CatsModel data0 = value;
                                      if (data0.id! == 0) {
                                        currencyName = '₽';
                                      } else if (data0.id == 1) {
                                        currencyName = '₸';
                                      } else if (data0.id == 2) {
                                        currencyName = 'BYN';
                                      }
                                      setState(() {});
                                    });
                                  },
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(Assets.icons.dropDownIcon.path, scale: 2.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  if (filledCount == 1)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FieldsProductRequest(
                            titleText: 'Скидка ,% ',
                            hintText: 'Введите размер скидки',
                            star: true,
                            arrow: false,
                            controller: compoundController,
                            textInputNumber: true,
                            errorText: fieldStep1Errors['compound'],
                          ),
                        ),
                        SizedBox(width: 4),
                        Container(
                          width: 96,
                          height: 52,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 14),
                          decoration: BoxDecoration(
                            color: Color(0xffEAECED),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(compoundValue),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  final List<CatsModel> nds0 = [
                                    CatsModel(id: 0, name: 'Рубль, ₽'),
                                    CatsModel(id: 1, name: 'Процент, %'),
                                  ];

                                  showSellerCatsOptions(context, 'Скидка', nds0, false, (value) {
                                    final CatsModel data0 = value;
                                    if (data0.name! == 'Рубль, ₽') {
                                      compoundValue = '₽';
                                    } else {
                                      compoundValue = '%';
                                    }
                                    setState(() {});
                                  });
                                },
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Image.asset(Assets.icons.dropDownIcon.path, scale: 2.1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  if (filledCount == 1)
                    FieldsProductRequest(
                      titleText: 'НДС (налог на добавленную стоимость)',
                      hintText: 'Выберите НДС',
                      star: true,
                      arrow: true,
                      readOnly: true,
                      controller: ndsController,
                      textInputNumber: true,
                      errorText: fieldStep1Errors['nds'],
                      onPressed: () async {
                        final List<CatsModel> nds = [
                          CatsModel(id: 0, name: '5 %'),
                          CatsModel(id: 1, name: '7 %'),
                          CatsModel(id: 2, name: '10 %'),
                          CatsModel(id: 3, name: '20 %'),
                          CatsModel(id: 4, name: 'Не облагается'),
                        ];

                        showSellerCatsOptions(context, 'Выбор НДС', nds, false, (value) {
                          final CatsModel data0 = value;

                          setState(() {
                            ndsController.text = data0.name!;
                          });
                        });
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
                      errorText: fieldStep1Errors['point'],
                    ),

                  if (filledCount == 1)
                    FieldsProductRequest(
                      titleText: 'Вознаграждение блогеру ,% ',
                      hintText: 'Введите вознаграждение ',
                      star: true,
                      arrow: false,
                      controller: pointsBloggerController,
                      textInputNumber: true,
                      errorText: fieldStep1Errors['pointBlogger'],
                    ),
                  if (filledCount == 1)
                    BlocBuilder<MetaCubit, MetaState>(
                      builder: (context, state) {
                        if (state is MetaStateLoaded) {
                          metasBody.addAll([
                            state.metas.terms_of_use!,
                            state.metas.privacy_policy!,
                            state.metas.contract_offer!,
                            state.metas.shipping_payment!,
                            state.metas.TTN!,
                          ]);
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MetasPage(title: metas[3], body: metasBody[3]),
                                ),
                              );
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
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Типового договора на оказание рекламных услуг\n",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.mainPurpleColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.indigoAccent),
                          );
                        }
                      },
                    ),

                  if (filledCount == 1)
                    FieldsProductRequest(
                      titleText: 'Количество в наличии ',
                      hintText: 'Введите количество',
                      star: false,
                      arrow: false,
                      controller: countController,
                      textInputNumber: true,
                      errorText: fieldStep1Errors['count'],
                    ),
                  if (filledCount == 1)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      decoration: BoxDecoration(
                        color: Color(0xffEAECED),
                        borderRadius: BorderRadius.circular(16),
                      ),
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
                                  style: AppTextStyles.size16Weight600,
                                ),
                                Text(
                                  'Если товара нет в наличии — можно ли оформить заказ?',
                                  style: AppTextStyles.size14Weight400.copyWith(
                                    color: Color(0xff808080),
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          AppSwitch(
                            value: isSwitchedBs,
                            onChanged: (v) => toggleSwitchBs(v),
                            //  setState(() => isSwitchedBs = v)
                          ),
                        ],
                      ),
                    ),

                  if (filledCount == 1) SizedBox(height: 100),
                  if (filledCount == 2)
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 82,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            decoration: BoxDecoration(
                              color: AppColors.kGray2,
                              borderRadius: BorderRadius.circular(16),
                            ),
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
                                      Text(
                                        'Включить продажу оптом',
                                        style: AppTextStyles.size16Weight600,
                                      ),
                                      Text(
                                        'Доступно только для партнёров платформы',
                                        style: AppTextStyles.size14Weight400.copyWith(
                                          color: Color(0xff808080),
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                AppSwitch(
                                  value: isSwitchedOptom,
                                  onChanged: (v) => toggleSwitchOptom(v),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (filledCount == 2) SizedBox(height: 12),
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
                              color: AppColors.kBackgroundColor,
                            ),
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
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${optomCount[index].count} шт',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
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
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${optomCount[index].price} ₽',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
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
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${optomCount[index].total} шт',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
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
                                  child: Icon(Icons.close, color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),

                  if (filledCount == 2 && isSwitchedOptom)
                    InkWell(
                      onTap: () {
                        showSellerOptomOptions(context, 'Добавить оптовую продажу', (
                          OptomPriceSellerDto value,
                        ) {
                          optomPriceController.text = value.price;
                          optomCountController.text = value.count;
                          optomTotalController.text = value.total;

                          if (GetStorage().read('seller_partner') != '1') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('У вас нет партнерство'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );

                            optomPriceController.clear();
                            optomCountController.clear();
                            optomTotalController.clear();

                            return;
                          }
                          if (optomPriceController.text.isNotEmpty) {
                            bool exists = false;

                            for (var element in optomCount) {
                              if (element.count == optomCountController.text) {
                                exists = true;
                                setState(() {});
                              }
                              continue;
                            }

                            if (!exists) {
                              optomCount.add(
                                OptomPriceSellerDto(
                                  price: optomPriceController.text,
                                  count: optomCountController.text,
                                  total: optomTotalController.text,
                                ),
                              );

                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Данные уже имеется!'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              optomPriceController.clear();
                              optomCountController.clear();
                              optomTotalController.clear();
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Нет данных!'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
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
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 40,
                        child: Text(
                          '+ Добавить',
                          style: AppTextStyles.size16Weight600.copyWith(
                            color: AppColors.mainPurpleColor,
                          ),
                        ),
                      ),
                    ),

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
                          dataWidget.add(existing); // Используем сохранённый (или с 0)
                        }

                        showSellerSizeCountOptions(
                          context,
                          'Укажите размер и количество',
                          dataWidget,
                          (List<SizeCountSellerDto> values) {
                            // Обновим sizeCount, но не обнуляем
                            for (var newItem in values) {
                              final index = sizeCount.indexWhere((i) => i.id == newItem.id);
                              if (index != -1) {
                                // Обновим count
                                sizeCount[index] = newItem;
                              } else {
                                // Добавим, если новое
                                sizeCount.add(newItem);
                              }
                            }

                            // Обновим отображаемый текст
                            String sizeNames = sizeCount.map((e) => e.name).join(', ');
                            sizeCountController.text = sizeNames;

                            setState(() {});
                          },
                        );
                      },
                    ),

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
                          final isSelected = colorCount.any((i) => i.color_id == e.id.toString());

                          dataWidget.add(CatsModel(id: e.id, name: e.name, isSelect: isSelected));
                        }
                        showSellerCharacteristicsOptions(context, 'Укажите цвета', dataWidget, (
                          List<CatsModel> values,
                        ) {
                          for (var e in values) {
                            final colorId = e.id.toString();
                            final colorName = e.name ?? 'Пустое';

                            // Если уже есть — обновить, если нет — добавить
                            final index = colorCount.indexWhere(
                              (element) => element.color_id == colorId,
                            );
                            if (index != -1) {
                              colorCount[index] = ColorCountSellerDto(
                                color_id: colorId,
                                name: colorName,
                                count: colorCount[index].count, // сохраняем старый count
                              );
                            } else {
                              colorCount.add(
                                ColorCountSellerDto(color_id: colorId, name: colorName, count: '0'),
                              );
                            }

                            // Обновляем checkColors аналогично
                            final exists = checkColors!.any((c) => c.name == colorName);
                            if (!exists) {
                              checkColors!.add(CatsModel(name: colorName));
                            }
                          }

                          String colorNames = values.map((e) => e.name ?? 'Пустое').join(', ');
                          colorCountController.text = colorNames;
                          setState(() {});
                        });
                      },
                    ),

                  if (filledCount == 3)
                    SizedBox(
                      height: characteristics!.length * 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true, // 🔑 делает ListView высотой по содержимому
                              physics:
                                  const NeverScrollableScrollPhysics(), // 🔑 запретить прокрутку внутри
                              itemCount: characteristics?.length ?? 0,
                              itemBuilder: (context, index) {
                                final item = characteristics![index];
                                final matched = subCharacteristicsValue
                                    ?.where((e) => e.mainId == item.id)
                                    .toList();
                                final matchedItem = matched != null && matched.isNotEmpty
                                    ? matched.first
                                    : null;
                                return FieldsProductRequest(
                                  titleText: item.key ?? '',
                                  hintText: matchedItem?.value ?? 'Выберите из списка',
                                  hintColor: matchedItem?.value != null ? true : false,
                                  star: true,
                                  arrow: true,
                                  onPressed: () async {
                                    final subIndexCharacteristics =
                                        await BlocProvider.of<CharacteristicSellerCubit>(
                                          context,
                                        ).subCharacteristic(id: item.id.toString());

                                    if (!context.mounted) return;

                                    showSellerListCharacteristicsOptions(
                                      context,
                                      item.key ?? 'Добавить характеристику',
                                      'params',
                                      subIndexCharacteristics!,
                                      (CharacteristicsModel value) {
                                        {
                                          final newCharacteristic = CharacteristicsModel(
                                            id: item.id,
                                            key: item.key,
                                            value: item.value,
                                          );

                                          final newSubCharacteristic = CharacteristicsModel(
                                            id: value.id,
                                            mainId: item.id,
                                            key: value.key,
                                            value: value.value,
                                          );

                                          characteristicsValue!.removeWhere((e) => e.id == item.id);
                                          subCharacteristicsValue!.removeWhere(
                                            (e) => e.mainId == item.id,
                                          );

                                          characteristicsValue!.add(newCharacteristic);
                                          subCharacteristicsValue!.add(newSubCharacteristic);

                                          setState(() {});
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (filledCount == 4)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Прикрепите фото', style: AppTextStyles.size16Weight600),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                final List<Map<String, String>> options = [
                                  {
                                    'title': 'Выбрать из галереи',
                                    'iconPath': Assets.icons.galleryIcon.path,
                                  },
                                  {
                                    'title': 'Открыть камеру',
                                    'iconPath': Assets.icons.cameraIcon.path,
                                  },
                                ];
                                showUploadMediaPicker(context, 'Загрузить фото', options, (value) {
                                  context.router.pop();
                                  switch (value) {
                                    case 'Выбрать из галереи':
                                      change = false;
                                      setState(() {
                                        change;
                                      });
                                      _getImage();
                                      break;
                                    case 'Открыть камеру':
                                      change = true;
                                      setState(() {
                                        change;
                                      });
                                      _getImage();
                                      break;
                                  }
                                });
                              },
                              child: DottedBorder(
                                dashPattern: [4, 4],
                                strokeWidth: 1,
                                color: Color(0xff8E8E93),
                                radius: Radius.circular(16),
                                borderType: BorderType.RRect,
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xffEAECED),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Image.asset(
                                    Assets.icons.cameraAddIcon.path,
                                    color: AppColors.mainPurpleColor,
                                    height: 32,
                                    width: 32,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            _image.isNotEmpty
                                ? SizedBox(
                                    width: 235,
                                    height: 120,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.zero,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: _image.length,
                                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: 120,
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(16),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color(0xff8E8E93),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: Image.file(
                                                    File(_image[index]!.path),
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) =>
                                                        Container(
                                                          color: Colors.grey[200],
                                                          child: const Icon(
                                                            Icons.broken_image,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      setState(() => _image.removeAt(index)),
                                                  child: Container(
                                                    width: 28,
                                                    height: 28,
                                                    alignment: Alignment.center,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      Assets.icons.trashGreyIcon.path,
                                                      width: 16,
                                                      height: 16,
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
                                : SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Загрузите до 30 фото (800×800 px, белый фон)',
                          style: AppTextStyles.size13Weight500.copyWith(color: Color(0xff636366)),
                        ),
                      ],
                    ),

                  if (filledCount == 4)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          const Text('Прикрепите видео', style: AppTextStyles.size16Weight600),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_video != null) {
                                    _removeVideo();
                                    return;
                                  }
                                  final List<Map<String, String>> options = [
                                    {
                                      'title': 'Выбрать из галереи',
                                      'iconPath': Assets.icons.galleryIcon.path,
                                    },
                                    {
                                      'title': 'Открыть камеру',
                                      'iconPath': Assets.icons.cameraIcon.path,
                                    },
                                  ];
                                  showUploadMediaPicker(context, 'Загрузить видео', options, (
                                    value,
                                  ) {
                                    context.router.pop();
                                    switch (value) {
                                      case 'Выбрать из галереи':
                                        change = false;
                                        setState(() {
                                          change;
                                        });
                                        _getVideo();
                                        break;
                                      case 'Открыть камеру':
                                        change = true;
                                        setState(() {
                                          change;
                                        });
                                        _getVideo();
                                        break;
                                    }
                                  });
                                },
                                child: DottedBorder(
                                  dashPattern: [4, 4],
                                  strokeWidth: 1,
                                  color: Color(0xff8E8E93),
                                  radius: Radius.circular(16),
                                  borderType: BorderType.RRect,
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Color(0xffEAECED),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child:
                                        (_video != null &&
                                            _controller != null &&
                                            _controller!.value.isInitialized)
                                        ? Stack(
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: AspectRatio(
                                                    aspectRatio: _controller!.value.aspectRatio,
                                                    child: VideoPlayer(_controller!),
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  alignment: Alignment.center,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    Assets.icons.trashGreyIcon.path,
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Center(
                                            child: Image.asset(
                                              Assets.icons.uploadVideoIcon.path,
                                              color: AppColors.mainPurpleColor,
                                              scale: 2.1,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Формат Reels (1080×1920 px, до 30 сек)',
                            style: AppTextStyles.size13Weight500.copyWith(color: Color(0xFF636366)),
                          ),
                        ],
                      ),
                    ),
                  if (filledCount == 5)
                    Container(
                      width: 166,
                      constraints: BoxConstraints(minHeight: 60),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffF7F7F7),
                        borderRadius: BorderRadius.circular(16),
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
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: InkWell(
                                  onTap: () => toggleCheckboxFBS(!isCheckedFBS),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    curve: Curves.easeOut,
                                    constraints: const BoxConstraints.tightFor(
                                      width: 24,
                                      height: 24,
                                    ),
                                    child: Image.asset(
                                      !isCheckedFBS
                                          ? Assets.icons.defaultCheckIcon.path
                                          : Assets.icons.defaultUncheckIcon.path,
                                      color: !isCheckedFBS
                                          ? AppColors.mainPurpleColor
                                          : Color(0xffD1D1D6),
                                      scale: 1.5,
                                      height: 32,
                                      width: 32,
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
                                        text: 'FBS (realFBS)',
                                        style: TextStyle(fontWeight: FontWeight.w600),
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
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: InkWell(
                                  onTap: () => toggleCheckboxFBS(!isCheckedFBS),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    curve: Curves.easeOut,
                                    constraints: const BoxConstraints.tightFor(
                                      width: 24,
                                      height: 24,
                                    ),
                                    child: Image.asset(
                                      isCheckedFBS
                                          ? Assets.icons.defaultCheckIcon.path
                                          : Assets.icons.defaultUncheckIcon.path,
                                      color: isCheckedFBS
                                          ? AppColors.mainPurpleColor
                                          : Color(0xffD1D1D6),
                                      scale: 1.5,
                                      height: 32,
                                      width: 32,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
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
                                        style: TextStyle(fontWeight: FontWeight.w600), // жирный
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
                      errorText: fieldStep5Errors['width'],
                      textInputNumber: true,
                    ),
                  if (filledCount == 5 && isCheckedFBS)
                    FieldsProductRequest(
                      titleText: 'Высота, мм ',
                      hintText: 'Введите высоту',
                      star: true,
                      arrow: false,
                      controller: heightController,
                      errorText: fieldStep5Errors['height'],
                      textInputNumber: true,
                    ),
                  if (filledCount == 5 && isCheckedFBS)
                    FieldsProductRequest(
                      titleText: 'Глубина, мм ',
                      hintText: 'Введите глубину',
                      star: true,
                      arrow: false,
                      controller: deepController,
                      errorText: fieldStep5Errors['deep'],
                      textInputNumber: true,
                    ),
                  if (filledCount == 5 && isCheckedFBS)
                    FieldsProductRequest(
                      titleText: 'Вес, г ',
                      hintText: 'Введите вес',
                      star: true,
                      arrow: false,
                      controller: massaController,
                      errorText: fieldStep5Errors['massa'],
                      textInputNumber: true,
                    ),
                  if (filledCount == 5) const SizedBox(height: 60),

                  if (filledCount == 6) SizedBox(height: 10),
                  if (filledCount == 6)
                    FieldsProductRequest(
                      titleText: 'География продаж:',
                      hintText: _locationSelect,
                      star: false,
                      arrow: true,
                      hintColor: false,
                      readOnly: true,
                      onPressed: () {
                        showSellerCatsOptions(context, 'Выбор локации', _locations, false, (value) {
                          final CatsModel data = value;

                          if (data.name == 'Регион') {
                            _regionsArray();
                          }
                          if (data.name == 'Город/населенный пункт') {
                            _citiesArray('RU');
                          }

                          setState(() {
                            _locationSelect = data.name ?? 'Не выбрано';
                          });
                        });
                      },
                      textInputNumber: false,
                    ),
                  if (filledCount == 6 &&
                      (_locationSelect == 'Регион' ||
                          _locationSelect == 'Город/населенный пункт' ||
                          _locationSelect == 'Моя локация'))
                    FieldsProductRequest(
                      titleText: _locationSeller,
                      hintText: _locationSeller,
                      star: false,
                      arrow: true,
                      hintColor: false,
                      readOnly: true,
                      onPressed: () {
                        if (_locationSelect == 'Регион' ||
                            _locationSelect == 'Город/населенный пункт') {
                          showSellerCatsOptions(context, _locationSelect, _regions, false, (value) {
                            setState(() {
                              cats = value;

                              _locationSeller = cats?.name ?? '';
                            });
                          });
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MapSellerPickerPage(lat: 43.238949, long: 76.889709),
                            ),
                          );
                        }
                      },
                      textInputNumber: false,
                    ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: SizedBox(
            height: 52,
            child: InkWell(
              onTap: () async {
                if (!_ensureStep1Valid() && filledCount == 1) return;

                if (filledCount == 4) {
                  if (!_ensureStep4Valid()) return;
                }

                if (filledCount == 5 && isCheckedFBS) {
                  if (!_ensureStep5Valid()) return;
                }

                increaseProgress();

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
                    if (fulfillment == 'realFbs') {
                      if (widthController.text.isEmpty ||
                          heightController.text.isEmpty ||
                          deepController.text.isEmpty ||
                          massaController.text.isEmpty) {
                        filledCount--;
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Заполните данные для доставки'),
                            backgroundColor: Colors.orangeAccent,
                          ),
                        );
                        return;
                      }
                    }

                    await BlocProvider.of<ProductSellerCubit>(context).store(
                      priceController.text,
                      countController.text,
                      compoundController.text,
                      cats?.id.toString() ?? '',
                      subCats?.id?.toString(),
                      brands?.id?.toString(),
                      colors?.id.toString() ?? '',
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
                      _video?.path,
                    );
                  } else {
                    filledCount--;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Заполните данные'),
                        backgroundColor: Colors.orangeAccent,
                      ),
                    );
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.mainPurpleColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Далее',
                  style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
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
  final int? maxLines;
  final String? errorText;

  const FieldsProductRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.hintColor,
    this.controller,
    this.cats,
    this.textInputNumber,
    super.key,
    this.onPressed,
    this.readOnly = false,
    this.maxLines,
    this.errorText,
  });

  @override
  State<FieldsProductRequest> createState() => _FieldsProductRequestState();
}

class _FieldsProductRequestState extends State<FieldsProductRequest> {
  void _handleTap() {
    if (widget.onPressed != null) widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    final bool isReadOnlyEffective = (widget.hintColor == false || widget.hintColor == null)
        ? widget.readOnly
        : true;

    final hasError = widget.errorText != null;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onPressed, // клик по всей области (заголовок + поле)
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  hasError ? widget.errorText! : widget.titleText,
                  style: AppTextStyles.size13Weight500.copyWith(
                    color: hasError ? AppColors.mainRedColor : Color(0xFF636366),
                  ),
                ),
                widget.star
                    ? const Text(
                        ' *',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.mainRedColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 8),
            // Если хотите рипл по всему полю — можно обернуть в Material+InkWell (см. ниже)
            Container(
              height: (widget.maxLines == null || widget.maxLines == 1) ? 52 : null,
              decoration: BoxDecoration(
                color: hasError ? AppColors.kWhite : const Color(0xFFEAECED),
                borderRadius: BorderRadius.circular(16),
                border: hasError ? Border.all(color: AppColors.mainRedColor, width: 1.0) : null,
              ),
              child: TextField(
                controller: widget.controller,
                readOnly: isReadOnlyEffective,
                onTap: isReadOnlyEffective ? _handleTap : null,
                keyboardType: (widget.maxLines != null && widget.maxLines! > 1)
                    ? TextInputType.multiline
                    : ((widget.textInputNumber == false || widget.textInputNumber == null)
                          ? TextInputType.text
                          : const TextInputType.numberWithOptions(signed: true, decimal: true)),
                style: AppTextStyles.size16Weight400,
                maxLines: widget.maxLines ?? 1,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: AppTextStyles.size16Weight400.copyWith(
                    color: hasError
                        ? AppColors.mainRedColor
                        : (widget.hintColor == null || widget.hintColor != true)
                        ? const Color(0xFF8E8E93)
                        : const Color(0xFF0F0F0F),
                  ),
                  suffixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                  suffixIcon: widget.arrow
                      ? InkWell(
                          onTap: _handleTap,
                          child: Image.asset(Assets.icons.dropDownIcon.path, scale: 2.1),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
