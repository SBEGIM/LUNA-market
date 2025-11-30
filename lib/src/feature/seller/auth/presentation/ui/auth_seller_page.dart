import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/login_seller_page.dart';

@RoutePage()
class AuthSellerPage extends StatefulWidget {
  final bool? BackButton;
  const AuthSellerPage({this.BackButton, Key? key}) : super(key: key);

  @override
  State<AuthSellerPage> createState() => _AuthSellerPageState();
}

class _AuthSellerPageState extends State<AuthSellerPage> {
  int segmentValue = 0;

  final List<bool> selectedBotton = [true, false];
  int currentIndex = 0;
  String title = 'Войти в кабинет продавца';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          toolbarHeight: 20,
          backgroundColor: Colors.white,
          elevation: 0,
          // centerTitle: true,
          // title: Text(
          //   title,
          //   style: AppTextStyles.appBarTextStyle,
          // ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 2.1),
          ),
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(60),
          //   child: Column(
          //     children: [
          //       Container(
          //         height: 12,
          //         color: AppColors.kBackgroundColor,
          //       ),
          //       Container(
          //         padding: const EdgeInsets.only(
          //           top: 8,
          //           left: 16,
          //           bottom: 8,
          //           right: 16,
          //           // right: screenSize.height * 0.016,
          //         ),
          //         child: CustomSwitchButton<int>(
          //           groupValue: segmentValue,
          //           children: {
          //             0: Container(
          //               alignment: Alignment.center,
          //               height: 39,
          //               width: MediaQuery.of(context).size.width,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(4),
          //               ),
          //               child: Text(
          //                 'Вход',
          //                 style: TextStyle(
          //                   fontSize: 15,
          //                   fontWeight: segmentValue == 0
          //                       ? FontWeight.w700
          //                       : FontWeight.w500,
          //                   color: segmentValue == 0
          //                       ? Colors.black
          //                       : const Color(0xff9B9B9B),
          //                 ),
          //               ),
          //             ),
          //             1: Container(
          //               width: MediaQuery.of(context).size.width,
          //               alignment: Alignment.center,
          //               height: 39,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(4),
          //               ),
          //               child: Text(
          //                 'Регистрация',
          //                 style: TextStyle(
          //                   fontWeight: segmentValue == 1
          //                       ? FontWeight.w700
          //                       : FontWeight.w500,
          //                   fontSize: 14,
          //                   color: segmentValue == 1
          //                       ? Colors.black
          //                       : const Color(0xff9B9B9B),
          //                 ),
          //               ),
          //             ),
          //           },
          //           onValueChanged: (int? value) async {
          //             if (value != null) {
          //               value == 0
          //                   ? (title = 'Войти в кабинет продавца')
          //                   : (title = 'Заявка на сотрудничество');
          //               segmentValue = value;
          //             }
          //             setState(() {});
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 22.0),
          //     child: SvgPicture.asset('assets/icons/cancel.svg'),
          //     // child: Ico(
          //     //   onTap: () {},
          //     // ),
          //   ),
          // ],
        ),
        body: LoginSellerPage(),
        // body: Container(
        //   color: AppColors.kBackgroundColor,
        //   child: IndexedStack(
        //     index: segmentValue,
        //     children: const [
        //       LoginSellerPage(),
        //       RegisterSellerPage()
        //       // const BlogAuthPage(),
        //       // BlogRequestPage(),
        //       // ViewRegisterPage(),
        //       // AuthPage(),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
