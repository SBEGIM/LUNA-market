import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';

import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../coop_request/presentation/ui/coop_request_page.dart';

class CreateProductPage extends StatefulWidget {
  CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
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
          onTap: () {
            //  Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) =>  CreateProductPage()),
            //       );
            // Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const FieldsCoopRequest(
              titleText: 'Артикул *',
              hintText: 'Введите артикул  ',
            ),
            const FieldsCoopRequest(
              titleText: 'Цена товара *',
              hintText: 'Введите цену  ',
            ),
            const FieldsCoopRequest(
              titleText: 'Скидка при оплате наличными, %',
              hintText: 'Введите размер скидки',
            ),
            const FieldsCoopRequest(
              titleText: 'Категория *',
              hintText: 'Выберите категорию',
            ),
            const FieldsCoopRequest(
              titleText: 'Название товара *',
              hintText: 'Введите название товара',
            ),
            const FieldsCoopRequest(
              titleText: 'Наименование бренда *',
              hintText: 'Выберите бренд',
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
            const FieldsCoopRequest(
              titleText: 'Тип *',
              hintText: 'Выберите тип',
            ),
            const FieldsCoopRequest(
              titleText: 'Количество в комплекте *',
              hintText: 'Выберите количество',
            ),
            const FieldsCoopRequest(
              titleText: 'Цвет ',
              hintText: 'Выберите цвет',
            ),
            const FieldsCoopRequest(
              titleText: 'Ширина, мм',
              hintText: 'Введите ширину',
            ),
            const FieldsCoopRequest(
              titleText: 'Высота, мм',
              hintText: 'Введите высоту',
            ),
            const FieldsCoopRequest(
              titleText: 'Глубина, мм',
              hintText: 'Введите глубину',
            ),
            const FieldsCoopRequest(
              titleText: 'Вес, г',
              hintText: 'Введите вес',
            ),
            const FieldsCoopRequest(
              titleText: 'Дополнительно',
              hintText: 'Для дополнительной информации',
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
                      children: const [
                        Icon(
                          Icons.local_movies_rounded,
                          color: AppColors.kGray300,
                        ),
                        Text(
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
            const FieldsCoopRequest(
              titleText: 'Магазин *',
              hintText: 'Магазин',
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
