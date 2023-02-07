import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../core/common/constants.dart';
import '../../../../app/widgets/custom_back_button.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  int index = 0;
  final _box = GetStorage();

  @override
  void initState() {
    index = _box.read('language_index');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Язык приложения',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            index = 1;
            _box.write('language_index', index);
            setState(() {
              index;
            });
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 13, right: 13, top: 20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/temp/kaz.svg',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                    width: 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Қазақша',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        index == 1
                            ? const Icon(
                                Icons.check,
                                size: 20,
                                color: AppColors.kPrimaryColor,
                              )
                            : Container()
                      ],
                    ))
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            index = 2;
            _box.write('language_index', index);
            setState(() {
              index;
            });
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 13, right: 13, top: 20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/temp/rus.svg',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                    width: 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Русский',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        index == 2
                            ? const Icon(
                                Icons.check,
                                size: 20,
                                color: AppColors.kPrimaryColor,
                              )
                            : Container()
                      ],
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
