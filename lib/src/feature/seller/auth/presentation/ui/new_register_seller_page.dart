import 'package:auto_route/auto_route.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/data/DTO/register_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/register_seller_cubit.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;
import 'package:haji_market/src/feature/seller/auth/presentation/ui/success_register_seller_page.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_register_type_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../core/constant/generated/assets.gen.dart';
import '../../../../home/data/model/cat_model.dart';
import '../../../product/presentation/widgets/cats_seller_page.dart';

@RoutePage()
class RegisterSellerPage extends StatefulWidget {
  const RegisterSellerPage({Key? key}) : super(key: key);

  @override
  State<RegisterSellerPage> createState() => _CoopRequestPageState();
}

class _CoopRequestPageState extends State<RegisterSellerPage> {
  bool isChecked = false;

  bool _passwordVisible = false;
  bool _repeatPasswordVisible = false;

  bool _visibleIconClear = false;
  bool __visibleIconView = false;
  bool isButtonEnabled = false;
  int typeOrganization = 1;

  CatsModel cats = CatsModel(id: 0, name: 'Выберите категорию');
  CountrySellerDto? countrySellerDto;

  TextEditingController iinController = TextEditingController();
  TextEditingController kppController = TextEditingController();
  TextEditingController ogvnController = TextEditingController();
  TextEditingController ogkvadController = TextEditingController();
  TextEditingController taxAuthorityController = TextEditingController();
  TextEditingController registerDateController = TextEditingController();
  TextEditingController legalAddressController = TextEditingController();
  TextEditingController founderController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController nameCompanyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController generalDirectorController = TextEditingController();
  // TextEditingController typeofActivityController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController articulController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController checkController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController =
      MaskedTextController(mask: '(000)-000-00-00');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг'
  ];

  List<String> metasBody = [];

  int filledCount = 1;
  double segmentHeight = 8;
  double segmentWidth = 8;
  double segmentSpacing = 2;
  int filledSegments = 1; // Начинаем с 1 заполненного сегмента
  int totalSegments = 3; // Всего сегментов
  Color filledColor = AppColors.mainPurpleColor;
  Color emptyColor = Colors.grey[200]!;
  double spacing = 5.0;
  String title = "Юридические данные";

  @override
  void initState() {
    if (BlocProvider.of<metaCubit.MetaCubit>(context).state
        is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }

    countrySellerDto = CountrySellerDto(
        code: '+7', flagPath: Assets.icons.ruFlagIcon.path, name: 'Россия');
    super.initState();
  }

  void _nextStep() {
    if (filledSegments < 2) {
      setState(() {
        filledSegments++;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Регистрация завершена')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.kGray,
      appBar: AppBar(
        toolbarHeight: 22,
        leading: InkWell(
            onTap: () {
              if (filledCount != 1) {
                filledCount--;
                if (filledCount == 2) {
                  title = 'Реквизиты банка';
                } else {
                  title = 'Юридические данные';
                }

                setState(() {
                  filledSegments = filledCount;
                });
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Icon(Icons.arrow_back)),
      ),
      // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
      // backgroundColor: Colors.white,
      // elevation: 0,
      // centerTitle: true,
      // title: const Text(
      //   'Заявка на сотрудничество',
      //   style: TextStyle(
      //     color: Colors.black,
      //     fontSize: 16,
      //     fontWeight: FontWeight.w500,
      //   ),
      // )),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 320,
                child: Text(
                  'Регистрация аккаунта продавца',
                  maxLines: 2,
                  style: AppTextStyles.size29Weight700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(title,
                  style: AppTextStyles.size16Weight400
                      .copyWith(color: Color(0xFF808080))),
            ),
            SizedBox(height: 8),

            // Прогресс-бар с пробелами
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: segmentHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: totalSegments,
                  separatorBuilder: (_, __) => SizedBox(width: segmentSpacing),
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
            ),

            SizedBox(height: 24),
            // EasyStepper(
            //   enableStepTapping: false,
            //   activeStep: filledSegments,
            //   activeStepTextColor: Colors.white,
            //   finishedStepTextColor: Colors.white,
            //   internalPadding: 10,
            //   stepRadius: 20,
            //   showLoadingAnimation: true,
            //   showStepBorder: false,
            //   activeStepIconColor: AppColors.kPrimaryColor,
            //   activeStepBorderColor: Colors.white,
            //   finishedStepBackgroundColor: AppColors.kPrimaryColor,
            //   activeStepBackgroundColor: AppColors.kGray400,
            //   unreachedStepBackgroundColor: Colors.grey,
            //   stepAnimationCurve: Curves.easeInQuart,
            //   lineStyle: LineStyle(
            //     lineLength: 80,
            //     lineSpace: 5,
            //     lineType: LineType.dashed,
            //     defaultLineColor: AppColors.kPrimaryColor,
            //     unreachedLineColor: Colors.grey,
            //     activeLineColor: AppColors.kPrimaryColor,
            //     finishedLineColor: AppColors.kPrimaryColor,
            //     lineWidth: 0,
            //     lineThickness: 1,
            //     // progress: 1,
            //     // //  lineSpace: 5,
            //     // // unreachedLineType : ,
            //     // progressColor: Colors.green,
            //     // progress: ,
            //   ),
            //   steps: [
            //     EasyStep(
            //       customStep: ClipRRect(
            //         borderRadius: BorderRadius.circular(15),
            //         child: Opacity(
            //           opacity: filledSegments >= 1 ? 1 : 0.3,
            //           child: Icon(
            //             Icons.business_sharp,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //       customTitle: const Text(
            //         'Юридические данные',
            //         style: TextStyle(
            //             fontWeight: FontWeight.w500,
            //             fontSize: 12,
            //             color: AppColors.kGray900),
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //     EasyStep(
            //       customStep: ClipRRect(
            //         borderRadius: BorderRadius.circular(15),
            //         child: Opacity(
            //           opacity: filledSegments >= 2 ? 1 : 0.3,
            //           child: Icon(
            //             Icons.shop_2,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //       customTitle: const Text(
            //         'Реквизиты банка',
            //         style: TextStyle(
            //             fontWeight: FontWeight.w500,
            //             fontSize: 12,
            //             color: AppColors.kGray900),
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //     EasyStep(
            //         customStep: ClipRRect(
            //           borderRadius: BorderRadius.circular(15),
            //           child: Opacity(
            //             opacity: filledSegments >= 3 ? 1 : 0.3,
            //             child: Icon(
            //               Icons.man,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //         customTitle: const Text(
            //           'Контактные   данные',
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               fontSize: 12,
            //               color: AppColors.kGray900),
            //           textAlign: TextAlign.center,
            //         )),
            //   ],
            //   onStepReached: (index) => setState(() => filledSegments = index),
            // ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    Visibility(
                      visible: filledSegments == 1 ? true : false,
                      child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            // const Row(
                            //   children: [
                            //     Text(
                            //       'Выберите тип организаций ',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.w400,
                            //           fontSize: 12,
                            //           color: AppColors.kGray900),
                            //     ),
                            //     Text(
                            //       '*',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.w400,
                            //           fontSize: 12,
                            //           color: Colors.red),
                            //     )
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       padding:
                            //           const EdgeInsets.symmetric(horizontal: 8),
                            //       alignment: Alignment.centerLeft,
                            //       decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(8),
                            //       ),
                            //       width: 140,
                            //       height: 47,
                            //       child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             const Text(
                            //               'ИП',
                            //               textAlign: TextAlign.center,
                            //             ),
                            //             Checkbox(
                            //               shape: const CircleBorder(),
                            //               value: typeOrganization == 1,
                            //               activeColor:
                            //                   AppColors.mainPurpleColor,
                            //               onChanged: ((value) {
                            //                 typeOrganization = 1;
                            //                 setState(() {});
                            //               }),
                            //             ),
                            //           ]),
                            //     ),
                            //     const SizedBox(
                            //       width: 20,
                            //     ),
                            //     Container(
                            //       padding:
                            //           const EdgeInsets.symmetric(horizontal: 8),
                            //       alignment: Alignment.centerLeft,
                            //       decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(8),
                            //       ),
                            //       width: 140,
                            //       height: 47,
                            //       child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             const Text(
                            //               'OОО',
                            //               textAlign: TextAlign.center,
                            //             ),
                            //             Checkbox(
                            //               value: typeOrganization == 2,
                            //               shape: const CircleBorder(),
                            //               activeColor:
                            //                   AppColors.mainPurpleColor,
                            //               onChanged: ((value) {
                            //                 typeOrganization = 2;
                            //                 setState(() {});
                            //               }),
                            //             ),
                            //           ]),
                            //     ),
                            //     // const SizedBox(
                            //     //   width: 20,
                            //     // ),
                            //     // Container(
                            //     //   padding: const EdgeInsets.symmetric(horizontal: 8),
                            //     //   alignment: Alignment.centerLeft,
                            //     //   decoration: BoxDecoration(
                            //     //     color: Colors.white,
                            //     //     borderRadius: BorderRadius.circular(8),
                            //     //   ),
                            //     //   width: 100,
                            //     //   height: 47,
                            //     //   child: Row(
                            //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     //       children: [
                            //     //         const Text(
                            //     //           'ОГРН',
                            //     //           textAlign: TextAlign.center,
                            //     //         ),
                            //     //         Checkbox(
                            //     //           shape: const CircleBorder(),
                            //     //           value: typeOrganization == 3,
                            //     //           activeColor: AppColors.kPrimaryColor,
                            //     //           onChanged: ((value) {
                            //     //             typeOrganization = 3;
                            //     //             setState(() {});
                            //     //           }),
                            //     //         ),
                            //     //       ]),
                            //     // ),
                            //   ],
                            // ),

                            // const SizedBox(
                            //   height: 10,
                            // ),
                            FieldsCoopRequest(
                              titleText: 'Название магазина',
                              hintText: 'Введите название магазина',
                              star: false,
                              arrow: false,
                              controller: nameController,
                            ),

                            FieldsCoopRequest(
                              titleText: 'Выберите тип организаций ',
                              hintText: typeOrganization == 1 ? 'ИП' : 'ООО',
                              star: false,
                              arrow: true,
                              // controller: catController,
                              onPressed: () async {
                                showSellerRegisterType(
                                  context,
                                  typeOrganization,
                                  typeCall: (type) {
                                    typeOrganization = type;
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                            FieldsCoopRequest(
                              titleText: 'ИНН ',
                              hintText: 'Введите ИНН',
                              star: false,
                              arrow: false,
                              number: true,
                              controller: iinController,
                            ),
                            FieldsCoopRequest(
                              titleText: 'Основная категория товаров ',
                              hintText: cats.name.toString(),
                              star: false,
                              arrow: true,
                              // controller: catController,
                              onPressed: () async {
                                final data =
                                    await Get.to(const CatsSellerPage());
                                if (data != null) {
                                  final CatsModel cat = data;

                                  setState(() {});
                                  catController.text = cat.id.toString();
                                  cats = cat;
                                }
                              },
                            ),
                            FieldsCoopRequest(
                              titleText: 'Юридический адрес',
                              hintText: 'Введите Юридический адрес',
                              star: false,
                              arrow: false,
                              controller: legalAddressController,
                            ),
                            // if (typeOrganization == 2)
                            //   FieldsCoopRequest(
                            //     titleText: 'КПП',
                            //     hintText: 'Введите КПП',
                            //     star: false,
                            //     arrow: false,
                            //     controller: kppController,
                            //   ),
                            // if (typeOrganization == 2)
                            //   FieldsCoopRequest(
                            //     titleText: 'ОГРН',
                            //     hintText: 'Введите ОГРН',
                            //     star: false,
                            //     arrow: false,
                            //     controller: ogvnController,
                            //   ),
                            // FieldsCoopRequest(
                            //   titleText: 'ОКВэД',
                            //   hintText: 'Введите ОКВэД',
                            //   star: false,
                            //   arrow: false,
                            //   controller: ogkvadController,
                            // ),
                            // FieldsCoopRequest(
                            //   titleText: 'Налоговый орган',
                            //   hintText: 'Введите Налоговый орган',
                            //   star: false,
                            //   arrow: false,
                            //   controller: taxAuthorityController,
                            // ),
                            FieldsCoopRequest(
                              titleText: 'Дата регистрации',
                              hintText: 'Введите Дата регистрации',
                              star: false,
                              arrow: false,
                              controller: registerDateController,
                            ),

                            // if (typeOrganization == 2)
                            //   FieldsCoopRequest(
                            //     titleText: 'Учредитель',
                            //     hintText: 'Введите Учредителя',
                            //     star: false,
                            //     arrow: false,
                            //     controller: founderController,
                            //   ),
                            // if (typeOrganization == 2)
                            //   FieldsCoopRequest(
                            //     titleText: 'Дата рождения',
                            //     hintText: 'Введите Дата рождения',
                            //     star: false,
                            //     arrow: false,
                            //     controller: birthdayController,
                            //   ),
                            // if (typeOrganization == 2)
                            //   FieldsCoopRequest(
                            //     titleText: 'Гражданство',
                            //     hintText: 'Введите Гражданство',
                            //     star: false,
                            //     arrow: false,
                            //     controller: nationalityController,
                            //   ),
                            FieldsCoopRequest(
                              titleText: 'Название компании ',
                              hintText: 'Введите название компании',
                              star: false,
                              arrow: false,
                              controller: nameCompanyController,
                            ),
                            // if (typeOrganization == 2)
                            //   FieldsCoopRequest(
                            //     titleText: 'Адрес ',
                            //     hintText: 'Введите Адрес',
                            //     star: false,
                            //     arrow: false,
                            //     controller: addressController,
                            //   ),
                            // if (typeOrganization == 2)
                            //   FieldsCoopRequest(
                            //     titleText: 'Ген.директор',
                            //     hintText: 'Введите Ген.директор',
                            //     star: false,
                            //     arrow: false,
                            //     controller: generalDirectorController,
                            //   ),
                            // FieldsCoopRequest(
                            //   titleText: 'Вид деятельности',
                            //   hintText: 'Введите Вид деятельности',
                            //   star: false,
                            //   arrow: false,
                            //   controller: typeofActivityController,
                            // ),
                            // FieldsCoopRequest(
                            //   titleText: 'Организация ФР',
                            //   hintText: 'Введите Организация ФР',
                            //   star: false,
                            //   arrow: false,
                            //   controller: organizationController,
                            // ),
                          ]),
                    ),
                    //bankController
                    //organizationController
                    //if==2
                    //generalDirectorController
                    //if==2
                    //addressController
                    //nameCompanyController
                    //if==2
                    //nationalityController
                    //if==2
                    //birthdayController
                    //if==2
                    //founderController
                    //legalAddressController
                    //registerDateController
                    //taxAuthorityController
                    //ogkvadController
                    //if==2
                    //ogvnController
                    //if==2
                    //kppController
                    //iinController
                    //typeOrganization

                    ///2
                    Visibility(
                      visible: filledSegments == 2 ? true : false,
                      child: ListView(shrinkWrap: true, children: [
                        const SizedBox(
                          height: 10,
                        ),
                        FieldsCoopRequest(
                          titleText: ' Банк',
                          hintText: 'Введите Банк',
                          star: false,
                          arrow: false,
                          controller: bankController,
                        ),
                        FieldsCoopRequest(
                          titleText: 'Счёт',
                          hintText: 'Введите счёт',
                          star: false,
                          arrow: false,
                          controller: checkController,
                        ),
                      ]),
                    ),

                    ///3

                    Visibility(
                      visible: filledSegments == 3 ? true : false,
                      child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            FieldsCoopRequest(
                              titleText: 'Контактное имя ',
                              hintText: 'Введите контактное имя',
                              star: false,
                              arrow: false,
                              controller: contactController,
                            ),
                            Text('Номер телефона',
                                textAlign: TextAlign.start,
                                style: AppTextStyles.size13Weight500
                                    .copyWith(color: Color(0xFF636366))),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showSellerLoginPhone(
                                      context,
                                      countryCall: (dto) {
                                        countrySellerDto = dto;
                                        setState(() {});
                                      },
                                    );
                                  },
                                  child: Shimmer(
                                    child: Container(
                                      height: 52,
                                      width: 83,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: AppColors.kGray2,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            countrySellerDto!.flagPath,
                                            width: 24,
                                            height: 24,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            '${countrySellerDto!.code}',
                                            style: AppTextStyles.size16Weight400
                                                .copyWith(
                                                    color: Color(0xFF636366)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),
                                // Поле ввода
                                Flexible(
                                  child: Container(
                                    height: 52,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: AppColors.kGray2,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: TextField(
                                      controller: phoneController,
                                      textInputAction: TextInputAction.send,
                                      keyboardType: TextInputType.phone,
                                      style: AppTextStyles.size16Weight400
                                          .copyWith(color: Color(0xFF636366)),
                                      decoration: InputDecoration(
                                        hintText: 'Введите номер телефона',
                                        hintStyle: AppTextStyles.size16Weight400
                                            .copyWith(color: Color(0xFF8E8E93)),
                                        border: InputBorder.none,
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      onSubmitted: (_) {
                                        FocusScope.of(context)
                                            .unfocus(); // закрыть клавиатуру
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            FieldsCoopRequest(
                              titleText: 'Email ',
                              hintText: 'Введите Email',
                              star: false,
                              arrow: false,
                              controller: emailController,
                            ),
                            Row(
                              children: [
                                Text('Пароль',
                                    style: AppTextStyles.size13Weight500
                                        .copyWith(color: Color(0xFF636366))),
                                const Text('*',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red)),
                              ],
                            ),
                            SizedBox(height: 4),
                            Container(
                              height: 52,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      16), // Increased horizontal padding
                              decoration: BoxDecoration(
                                color: AppColors.kGray2,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: passwordController,
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.text,
                                      obscureText: !_passwordVisible,
                                      style: AppTextStyles.size16Weight400
                                          .copyWith(color: Color(0xFF636366)),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Введите пароль',
                                        hintStyle: AppTextStyles.size16Weight400
                                            .copyWith(color: Color(0xFF8E8E93)),
                                        contentPadding: EdgeInsets
                                            .zero, // Better control over padding
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    child: Image.asset(
                                      _passwordVisible
                                          ? Assets
                                              .icons.passwordViewHiddenIcon.path
                                          : Assets.icons.passwordViewIcon.path,
                                      scale: 1.9,
                                      color: AppColors.kGray300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Text('Повторить  пароль',
                                    style: AppTextStyles.size13Weight500
                                        .copyWith(color: Color(0xFF636366))),
                                const Text('*',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red)),
                              ],
                            ),
                            SizedBox(height: 4),
                            Container(
                              height: 52,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      16), // Increased horizontal padding
                              decoration: BoxDecoration(
                                color: AppColors.kGray2,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: repeatPasswordController,
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.text,
                                      obscureText: !_repeatPasswordVisible,
                                      style: AppTextStyles.size16Weight400
                                          .copyWith(color: Color(0xFF636366)),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Повторите пароль',
                                        hintStyle: AppTextStyles.size16Weight400
                                            .copyWith(color: Color(0xFF8E8E93)),
                                        contentPadding: EdgeInsets
                                            .zero, // Better control over padding
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _repeatPasswordVisible =
                                            !_repeatPasswordVisible;
                                      });
                                    },
                                    child: Image.asset(
                                      _repeatPasswordVisible
                                          ? Assets
                                              .icons.passwordViewHiddenIcon.path
                                          : Assets.icons.passwordViewIcon.path,
                                      scale: 1.9,
                                      color: AppColors.kGray300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isChecked = !isChecked;
                                        });
                                      },
                                      child: Image.asset(
                                        isChecked
                                            ? Assets.icons.defaultCheckIcon.path
                                            : Assets
                                                .icons.defaultUncheckIcon.path,
                                        scale: 1.9,
                                        color: isChecked
                                            ? AppColors.arrowColor
                                            : AppColors.kGray300,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    BlocBuilder<metaCubit.MetaCubit,
                                            metaState.MetaState>(
                                        builder: (context, state) {
                                      if (state is metaState.LoadedState) {
                                        metasBody.addAll([
                                          state.metas.terms_of_use!,
                                          state.metas.privacy_policy!,
                                          state.metas.contract_offer!,
                                          state.metas.shipping_payment!,
                                          state.metas.TTN!,
                                        ]);
                                        return Container(
                                          alignment: Alignment.topRight,
                                          child: Flexible(
                                            child: RichText(
                                              textAlign: TextAlign.left,
                                              text: TextSpan(
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.kGray300),
                                                children: <TextSpan>[
                                                  const TextSpan(
                                                    text:
                                                        "Нажимая «Зарегистрироваться», вы \nпринимаете",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () =>
                                                              Get.to(
                                                                  () =>
                                                                      MetasPage(
                                                                        title:
                                                                            metas[2],
                                                                        body: metasBody[
                                                                            2],
                                                                      )),
                                                    text:
                                                        ' политику конфиденциаль- \nности и',
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .mainPurpleColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () =>
                                                              Get.to(
                                                                  () =>
                                                                      MetasPage(
                                                                        title:
                                                                            metas[0],
                                                                        body: metasBody[
                                                                            0],
                                                                      )),
                                                    text:
                                                        ' условия использования',
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .mainPurpleColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center();
                                      }
                                    }),
                                  ]),
                            ),
                          ]),
                    ),
                    SizedBox(height: 100)
                  ]),
                ),
              ),
            )
          ]),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: InkWell(
            onTap: () async {
              if (filledSegments == 1) {
                if (typeOrganization == 1) {
                  if (iinController.text.isEmpty ||
                          // organizationController.text.isEmpty ||
                          nameCompanyController.text.isEmpty ||
                          legalAddressController.text.isEmpty ||
                          registerDateController.text.isEmpty
                      //     taxAuthorityController.text.isEmpty ||
                      //    ogkvadController.text.isEmpty) {
                      ) {
                    AppSnackBar.show(
                      context,
                      'Заполните все данные ИП *',
                      type: AppSnackType.error,
                    );

                    return;
                  }
                  setState(() {
                    filledSegments = 2;
                    filledCount = 2;
                    title = 'Реквизиты банка';
                  });

                  return;
                } else if (typeOrganization == 2) {
                  if (iinController.text.isNotEmpty ||
                      organizationController.text.isNotEmpty ||
                      nameCompanyController.text.isNotEmpty ||
                      legalAddressController.text.isNotEmpty ||
                      registerDateController.text.isNotEmpty ||
                      taxAuthorityController.text.isNotEmpty ||
                      ogkvadController.text.isNotEmpty) {
                    AppSnackBar.show(
                      context,
                      'Заполните все данные ООО *',
                      type: AppSnackType.error,
                    );

                    return;
                  }

                  if (generalDirectorController.text.isEmpty ||
                      addressController.text.isEmpty ||
                      nationalityController.text.isEmpty ||
                      birthdayController.text.isEmpty ||
                      founderController.text.isEmpty ||
                      ogvnController.text.isEmpty ||
                      kppController.text.isEmpty) {
                    AppSnackBar.show(
                      context,
                      'Заполните все данные ООО *',
                      type: AppSnackType.error,
                    );

                    return;
                  }
                  setState(() {
                    filledSegments = 2;
                    filledCount = 2;
                    title = 'Реквизиты банка';
                  });

                  return;
                }
              }

              if (filledSegments == 2) {
                if (bankController.text.isEmpty ||
                    checkController.text.isEmpty) {
                  AppSnackBar.show(
                    context,
                    'Заполните все данные о магазине *',
                    type: AppSnackType.error,
                  );
                  return;
                }
                setState(() {
                  filledSegments = 3;
                  filledCount = 3;
                  title = 'Контактные данные';
                });

                return;
              }

              if (filledSegments == 3) {
                if (contactController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    isChecked == false) {
                  AppSnackBar.show(
                    context,
                    'Заполните все контактные данные *',
                    type: AppSnackType.error,
                  );
                  return;
                }

                final RegisterSellerDTO registerDto = RegisterSellerDTO(
                    catName: catController.text,
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    password: passwordController.text,
                    iin: iinController.text,
                    userName: nameCompanyController.text,
                    check: checkController.text,
                    typeOrganization: typeOrganization,
                    kpp: kppController.text,
                    ogrn: ogvnController.text,
                    okved: ogkvadController.text,
                    tax_authority: taxAuthorityController.text,
                    date_register: registerDateController.text,
                    founder: founderController.text,
                    date_of_birth: birthdayController.text,
                    citizenship: nationalityController.text,
                    CEO: generalDirectorController.text,
                    organization_fr: organizationController.text,
                    bank: bankController.text,
                    company_name: nameCompanyController.text,
                    legal_address: legalAddressController.text);

                await BlocProvider.of<RegisterSellerCubit>(context)
                    .register(registerDto);
                if (!mounted) return;

                context.router.push(SuccessSellerRegisterRoute());
                // Get.to(SuccessSellerRegisterPage());

                // context.router.push(AuthSellerRoute());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AuthAdminPage()),
                // );

                // AppSnackBar.show(
                //   context,
                //   'Заявка отправлено',
                //   type: AppSnackType.error,
                // );

                return;
              } else {
                AppSnackBar.show(
                  context,
                  'Ой что-то пошло не так',
                  type: AppSnackType.error,
                );
              }

              // Navigator.pop(context);
            },
            child: SizedBox(
                height: 80,
                child: Column(
                  children: [
                    Container(
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.mainPurpleColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          filledSegments != 3 ? 'Далее' : 'Зарегистрироваться',
                          style: AppTextStyles.size18Weight600
                              .copyWith(color: AppColors.kWhite),
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(height: 12),
                  ],
                ))),
      ),
    );

    //  bottomSheet: );
  }
}

class FieldsCoopRequest extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final bool readOnly; // доп. флаг, если поле реально только для чтения
  final bool? number;
  final bool trueColor;
  final VoidCallback? onPressed; // если задан — поле работает как кнопка
  final String? icon;
  final TextEditingController? controller;

  const FieldsCoopRequest(
      {super.key,
      required this.hintText,
      required this.titleText,
      required this.star,
      required this.arrow,
      this.controller,
      this.onPressed,
      this.readOnly = false,
      this.number,
      this.trueColor = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final bool tapMode = onPressed != null; // режим «нажатия», без клавиатуры

    return Material(
      // для правильного InkWell-эффекта
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed, // тап по всей области
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок + звёздочка
              Row(
                children: [
                  Text(titleText,
                      style: AppTextStyles.size13Weight500
                          .copyWith(color: Color(0xFF636366))),
                  if (!star)
                    const Text('*',
                        style: TextStyle(fontSize: 12, color: Colors.red)),
                ],
              ),
              const SizedBox(height: 4),

              // Поле
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.kGray2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.left,
                  readOnly: tapMode || readOnly,
                  showCursor: !(tapMode || readOnly),
                  enableInteractiveSelection: !(tapMode || readOnly),
                  onTap: tapMode ? onPressed : null,
                  keyboardType: number == true
                      ? TextInputType.number
                      : TextInputType.text,
                  style: AppTextStyles.size16Weight400
                      .copyWith(color: Color(0xFF636366)),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    contentPadding: const EdgeInsets.all(
                      16,
                    ),
                    hintStyle: AppTextStyles.size16Weight400
                        .copyWith(color: Color(0xFF8E8E93)),
                    suffixIcon: arrow
                        ? Padding(
                            padding: EdgeInsets.only(
                                right:
                                    (icon != null && icon!.isNotEmpty) ? 0 : 0),
                            child: Image.asset(
                                (icon != null && icon!.isNotEmpty)
                                    ? icon!
                                    : Assets.icons.defaultArrowForwardIcon.path,
                                scale: 1.9,
                                color: (icon != null && icon!.isNotEmpty)
                                    ? AppColors.kGray300
                                    : null),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
