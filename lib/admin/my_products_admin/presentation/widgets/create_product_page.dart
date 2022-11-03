import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../../features/home/data/model/Cats.dart';
import '../../../admin_app/presentation/base_admin.dart';
import '../../../coop_request/presentation/ui/coop_request_page.dart';
import '../../data/bloc/product_admin_cubit.dart';
import '../../data/bloc/product_admin_state.dart';

class CreateProductPage extends StatefulWidget {
  final Cats cat;
  final Cats subCat;
  CreateProductPage({required this.cat, required this.subCat, Key? key})
      : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
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
        bottomSheet: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
          child: InkWell(
            onTap: () async {
              await BlocProvider.of<ProductAdminCubit>(context).product(
                  priceController.text,
                  countController.text,
                  compoundController.text,
                  cat_id.toString(),
                  brand_id.toString(),
                  descriptionController.text,
                  nameController.text);
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
        body: BlocConsumer<ProductAdminCubit, ProductAdminState>(
            listener: (context, state) {
          if (state is LoadedState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BaseAdmin()),
            );
          }
        }, builder: (context, state) {
          if (state is InitState) {
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
                  const FieldsProductRequest(
                    titleText: 'Категория ',
                    hintText: 'Выберите категорию',
                    star: false,
                    arrow: true,
                  ),
                  FieldsProductRequest(
                    titleText: 'Название товара ',
                    hintText: 'Введите название товара',
                    star: false,
                    arrow: false,
                    controller: nameController,
                  ),
                  const FieldsProductRequest(
                    titleText: 'Наименование бренда ',
                    hintText: 'Выберите бренд',
                    star: false,
                    arrow: true,
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
                  const FieldsProductRequest(
                    titleText: 'Тип ',
                    hintText: 'Выберите тип',
                    star: false,
                    arrow: true,
                  ),
                  FieldsProductRequest(
                    titleText: 'Количество в комплекте ',
                    hintText: 'Выберите количество',
                    star: false,
                    arrow: true,
                    controller: countController,
                  ),
                  const FieldsProductRequest(
                    titleText: 'Цвет ',
                    hintText: 'Выберите цвет',
                    star: true,
                    arrow: true,
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
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.camera_alt,
                                color: AppColors.kGray300,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Добавить изображение',
                                style: TextStyle(
                                    color: AppColors.kGray300,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
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
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/video.svg',
                                  color: Colors.grey),
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
          }
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        }));
  }
}

class FieldsProductRequest extends StatefulWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final TextEditingController? controller;
  const FieldsProductRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
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
                      onPressed: () {},
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
