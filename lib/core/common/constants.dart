import 'package:flutter/material.dart';

mixin AppColors {
  static const Color kBackgroundColor = Color(0xFFF1F1F1);
  static const Color kPrimaryColor = Color(0xFF1DC4CF);
  static const Color kPinkColor = Color(0xffEE46BC);
  static const Color kLightBlackColor = Color(0xff1F1F1F);
  static const Color kGray = Color(0xffF9FAFB);
  static const Color kGray1 = Color(0xffF8F8F8);
  static const Color kGray2 = Color(0xffF1F2F3);
  static const Color kGray4 = Color(0xffC3C7CE);
  static const Color kGray5 = Color(0xff757D8A);
  static const Color kGray6 = Color(0xff909499);
  static const Color steelGray = Color.fromRGBO(153, 162, 173, 1);
  static const Color kBGMessage = Color(0xffE9E9EB);
  static const Color kWhite = Colors.white;
  static const Color kSlidingSegment = Color.fromRGBO(0, 0, 0, 0.03);
  static const Color kNeutral = Color(0xff919191);
  static const Color kAzure = Color(0xff4986CC);
  static const Color kBg = Color(0xfff2f3f6);
  static const Color kBlueAlpha32 = Color(0x51ADD3FF);
  static const Color kYellowLight = Color.fromRGBO(255, 213, 79, 1);

  ///
  static const Color kDark = Color(0xff404D61);
  static const Color kCorrect = Color(0xff00BA88);
  // static const Color kCaption = Color(0xff4E4B66);
  // static const Color searchBg = Color.fromRGBO(239, 240, 247, 1.0);
  // static const Color searchText = Color.fromRGBO(110, 113, 145, 1); //4E4B66
  // static const Color catBg = Color.fromRGBO(247, 247, 252, 1.0);
  // static const Color kGray50 = Color.fromRGBO(249, 250, 251, 1);
  // static const Color kGray100 = Color.fromRGBO(242, 244, 247, 1);
  static const Color kGray200 = Color.fromRGBO(196, 200, 204, 1);
  static const Color kGray300 = Color.fromRGBO(153, 162, 173, 1);
  static const Color kGray400 = Color.fromRGBO(144, 148, 153, 1);
  static const Color kGray500 = Color.fromRGBO(102, 112, 133, 1);
  static const Color kGray600 = Color.fromRGBO(71, 84, 103, 1);
  static const Color kGray700 = Color.fromRGBO(69, 70, 71, 1);
  static const Color kGray750 = Color.fromRGBO(54, 55, 56, 1);
  static const Color kGray800 = Color.fromRGBO(44, 45, 46, 1);
  static const Color kGray900 = Color.fromRGBO(16, 24, 40, 1);
  static const Color kGray1000 = Color.fromRGBO(10, 10, 10, 1);

  static const Color kAlpha12 = Color.fromRGBO(0, 0, 0, 0.12);
  static const Color kBlueAlpha = Color(0xffe5f1ff);
  static const Color floatingActionButton = Color.fromRGBO(
    5,
    163,
    87,
    1.0,
  );
  static const Color reviewStar = Color.fromRGBO(255, 195, 0, 1);
  static const Color kReviewBg = Color(0xffF7F7FC);
}

mixin AppTextStyles {
  static const appBarTextStyle = TextStyle(
    fontSize: 17,
    color: AppColors.kLightBlackColor,
    fontWeight: FontWeight.w500,
  );
  static const catalogTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.kGray900,
    fontWeight: FontWeight.w400,
  );
  static const chanheLangTextStyle = TextStyle(
    fontSize: 17,
    color: AppColors.kGray900,
    fontWeight: FontWeight.w500,
  );
  static const drawer1TextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static const drawer2TextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.kGray900,
    fontWeight: FontWeight.w400,
  );
  static const kcolorPrimaryTextStyle = TextStyle(
    fontSize: 14,
    color: AppColors.kPrimaryColor,
    fontWeight: FontWeight.w500,
  );
    static const kcolorPartnerTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.kPrimaryColor,
    fontWeight: FontWeight.w400,
  );

  static const categoryTextStyle = TextStyle(
    fontSize: 15,
    color: AppColors.kGray900,
    fontWeight: FontWeight.w500,
  );
  static const bannerTextStyle = TextStyle(
    fontSize: 12,
    color: AppColors.kGray300,
    fontWeight: FontWeight.w400,
  );
  static const appBarTextStylea = TextStyle(
    fontSize: 20,
    color: AppColors.kGray900,
    fontWeight: FontWeight.w700,
  );

  static const defButtonTextStyle = TextStyle(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  static const timerInReRegTextStyle = TextStyle(
    fontSize: 17,
    color: Color(0xFFAAAEB3),
    fontWeight: FontWeight.w500,
  );
  static const kGray400Text = TextStyle(
    fontSize: 16,
    color: AppColors.kGray400,
    fontWeight: FontWeight.w500,
  );
}

mixin AppDecorations {
  static const List<BoxShadow> basicShadows = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 24,
      color: Color.fromRGBO(0, 0, 0, 0.08),
    ),
    BoxShadow(
      blurRadius: 2,
      color: Color.fromRGBO(0, 0, 0, 0.08),
    ),
  ];
}
