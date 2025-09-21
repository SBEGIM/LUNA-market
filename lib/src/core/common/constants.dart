import 'package:flutter/material.dart';

mixin AppColors {
  static const Color kBackgroundColor = Color(0xFFF6F6F6);
  static const Color kButtonColor = Color(0xffEAECED);
  static const Color kunSelectColor = Color(0xffAEAEB2);

  static const Color mainPurpleColor = Color(0xff6F32F8);
  static const Color purpleBorder = Color(0x4A6F32F8);

  static const Color mainPurpleGradient = Color(0xffCEE31C);

  static const Color mainIconPurpleColor = Color(0x106F32F8);

  static const Color mainBackgroundPurpleColor = Color(
    0x1A6F32F8,
  );

  static const Color kPrimaryColor = Color(0xFF1DC4CF);
  static const Color kBlueColor = Color.fromRGBO(129, 222, 232, 1);
  static const Color kPinkColor = Color(0xffEE46BC);
  static const Color kPinkChatColor = Color(0xffF1EBFE);

  static const Color kLightBlackColor = Color(0xff1F1F1F);

  static const Color kNeutralBlackColor = Color(0xFF3A3A3C);

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
  static const Color kYellowDark = Color(0xffCEE31C);
  static const Color tapeColorGray = Color(0x660F0F0F);

  ///
  static const Color kDark = Color(0xff404D61);

  static int getColorFromHex(String hexColor) {
    String newHexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (newHexColor.length == 6) {
      newHexColor = "FF$newHexColor";
    }
    return int.parse(newHexColor, radix: 16);
  }

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
  static const Color arrowColor = Color.fromRGBO(8, 19, 41, 1);
}

mixin AppTextStyles {
  static const appBarTextStyle = TextStyle(
    fontSize: 18,
    color: AppColors.kLightBlackColor,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w600,
  );

  static const sellerNameTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.kLightBlackColor,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w500,
  );
  static const catalogTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.kGray900,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w400,
  );
  static const chanheLangTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.kGray900,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w400,
  );
  static const drawer1TextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w500,
  );
  static const drawer2TextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.kGray900,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w400,
  );
  static const kcolorPrimaryTextStyle = TextStyle(
    fontSize: 14,
    letterSpacing: 0,
    color: AppColors.kPrimaryColor,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w500,
  );
  static const kcolorPartnerTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.kPrimaryColor,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w400,
  );

  static const categoryTextStyle = TextStyle(
    fontSize: 13,
    color: AppColors.kGray900,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
  );
  static const bannerTextStyle = TextStyle(
    fontSize: 11,
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );
  static const bannerTextDateStyle = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static const appBarTextStylea = TextStyle(
    fontSize: 20,
    color: AppColors.kGray900,
    fontFamily: 'SFProDisplay',
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
  );

  static const defButtonTextStyle = TextStyle(
      fontSize: 17,
      letterSpacing: 0,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: 'SFProDisplay');

  static const defaultButtonTextStyle = TextStyle(
      fontSize: 18,
      color: Colors.black,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: 'SFProDisplay');

  static const defaultAppBarTextStyle = TextStyle(
      fontSize: 22,
      color: Colors.black,
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontFamily: 'SFProDisplay');
  static const timerInReRegTextStyle = TextStyle(
    fontSize: 17,
    letterSpacing: 0,
    color: Color(0xFFAAAEB3),
    fontWeight: FontWeight.w500,
  );
  static const kGray400Text = TextStyle(
    fontSize: 16,
    letterSpacing: 0,
    color: AppColors.kGray400,
    fontWeight: FontWeight.w500,
  );

  static const counterSellerProfileTextStyle = TextStyle(
    fontSize: 16,
    letterSpacing: 0,
    color: Color(0xFF333333),
    fontWeight: FontWeight.w700,
    fontFamily: 'SFProDisplay',
  );
  static const counterSellerTitleTextStyle = TextStyle(
    fontSize: 11,
    letterSpacing: 0,
    color: Color(0xFF959595),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const navigationSelectLabelStyle = TextStyle(
    fontSize: 11,
    letterSpacing: 0,
    color: Color(0xFFAEAEB2),
    fontWeight: FontWeight.w500,
    fontFamily: 'SFProDisplay',
  );

  static const navigationUnSelectLabelStyle = TextStyle(
    fontSize: 11,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w500,
    fontFamily: 'SFProDisplay',
  );

  static const aboutTextStyle = TextStyle(
    fontSize: 16,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const statisticsTextStyle = TextStyle(
    fontSize: 14,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const titleTextStyle = TextStyle(
    fontSize: 18,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    fontFamily: 'SFProDisplay',
  );

  static const size11Weight400 = TextStyle(
    fontSize: 11,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const size12Weight400 = TextStyle(
    fontSize: 12,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const size12Weight500 = TextStyle(
    fontSize: 12,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const size13Weight400 = TextStyle(
    fontSize: 13,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const size13Weight500 = TextStyle(
    fontSize: 13,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w500,
    fontFamily: 'SFProDisplay',
  );

  static const size14Weight400 = TextStyle(
    fontSize: 14,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const size14Weight500 = TextStyle(
    fontSize: 14,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w500,
    fontFamily: 'SFProDisplay',
  );

  static const size14Weight600 = TextStyle(
    fontSize: 14,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w600,
    fontFamily: 'SFProDisplay',
  );

  static const size15Weight500 = TextStyle(
    fontSize: 15,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w500,
    fontFamily: 'SFProDisplay',
  );
  static const size15Weight600 = TextStyle(
    fontSize: 15,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w600,
    fontFamily: 'SFProDisplay',
  );

  static const size16Weight400 = TextStyle(
    fontSize: 16,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const size16Weight500 = TextStyle(
    fontSize: 16,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w500,
    fontFamily: 'SFProDisplay',
  );

  static const size16Weight600 = TextStyle(
    fontSize: 16,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w600,
    fontFamily: 'SFProDisplay',
  );

  static const size18Weight400 = TextStyle(
    fontSize: 18,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const size18Weight500 = TextStyle(
    fontSize: 18,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w400,
    fontFamily: 'SFProDisplay',
  );

  static const size18Weight600 = TextStyle(
    fontSize: 18,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w600,
    fontFamily: 'SFProDisplay',
  );

  static const size18Weight700 = TextStyle(
    fontSize: 18,
    letterSpacing: 0,
    color: Color(0xFF0F0F0F),
    fontWeight: FontWeight.w700,
    fontFamily: 'SFProDisplay',
  );

  static const size22Weight600 = TextStyle(
      fontSize: 22,
      color: Colors.black,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: 'SFProDisplay');

  static const size22Weight700 = TextStyle(
      fontSize: 22,
      color: Colors.black,
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
      fontFamily: 'SFProDisplay');

  static const size28Weight700 = TextStyle(
      fontSize: 28,
      color: Colors.black,
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontFamily: 'SFProDisplay');

  static const size29Weight700 = TextStyle(
      fontSize: 29,
      color: Colors.black,
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      fontFamily: 'SFProDisplay');
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

String getFormattedArticle(String article) {
  final articleChars = article.split('');
  if (articleChars.length >= 12) {
    return article;
  } else {
    StringBuffer newArticle = StringBuffer();
    for (int i = 0; i < (12 - (article.length)); i++) {
      articleChars.insert(0, '0');
    }
    for (final String chars in articleChars) {
      newArticle.write(chars);
    }
    return newArticle.toString();
  }
}

const kDeepLinkUrl = 'https://lunamarket.ru';
