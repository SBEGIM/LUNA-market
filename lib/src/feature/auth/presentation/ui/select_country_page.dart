// import 'package:flutter/material.dart';
// import 'package:haji_market/core/common/constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:haji_market/features/auth/data/models/country_dto.dart';
// import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';
// import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';

// class SelectCountryPage extends StatefulWidget {
//   const SelectCountryPage({Key? key}) : super(key: key);

//   @override
//   State<SelectCountryPage> createState() => _SelectCountryPageState();
// }

// int _selectedIndex = -1;

// List<CountryDto> country = [
//   CountryDto(title: 'Қазақстан', url: 'assets/temp/kaz.svg'),
//   CountryDto(title: 'Россия', url: 'assets/temp/rus.svg'),
//   CountryDto(title: 'Украина', url: 'assets/temp/ukr.svg'),
//   CountryDto(title: 'Беларусь', url: 'assets/temp/bel.svg'),
// ];

// class _SelectCountryPageState extends State<SelectCountryPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Выберите страну',
//           style: AppTextStyles.appBarTextStyle,
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Container(
//         color: AppColors.kBackgroundColor,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8)),
//                 height: MediaQuery.of(context).size.height * 0.232,
//                 child: ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: country.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                       onTap: () {
//                         setState(() {
//                           // устанавливаем индекс выделенного элемента
//                           _selectedIndex = index;
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 12.0, bottom: 12, left: 16, right: 16),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset(country[index].url),
//                                     const SizedBox(
//                                       width: 8,
//                                     ),
//                                     Text(
//                                       country[index].title,
//                                       style: const TextStyle(
//                                           color: AppColors.kGray900,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                                 _selectedIndex == index
//                                     ? SvgPicture.asset(
//                                         'assets/icons/done.svg',
//                                       )
//                                     : const SizedBox(),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                     //  ListTile(
//                     //   minLeadingWidth: 8,
//                     //   selected: index == _selectedIndex,
//                     //   leading: SvgPicture.asset(country[index].url),
//                     //   title: Text(
//                     //     country[index].title,
//                     //     style: AppTextStyles.appBarTextStyle,
//                     //   ),
//                     //   trailing: _selectedIndex == index
//                     //       ? SvgPicture.asset(
//                     //           'assets/icons/done.svg',
//                     //         )
//                     //       : const SizedBox(),
//                     // ));
//                   },
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.white,
//               height: MediaQuery.of(context).size.height * 0.124,
//               child: Center(
//                   child: DefaultButton(
//                 backgroundColor: AppColors.kPrimaryColor,
//                 text: 'Готово',
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ViewAuthRegisterPage()),
//                   );
//                 },
//                 color: Colors.white,
//                 width: 343,
//               )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
