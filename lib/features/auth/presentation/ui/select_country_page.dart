import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';

class SelectCountryPage extends StatefulWidget {
  const SelectCountryPage({Key? key}) : super(key: key);

  @override
  State<SelectCountryPage> createState() => _SelectCountryPageState();
}

int _selectedIndex = -1;

class _SelectCountryPageState extends State<SelectCountryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Выберите страну',
          style: AppTextStyles.appBarTextStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: AppColors.kBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                // height: MediaQuery.of(context).size.height * 0.242,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          setState(() {
                            // устанавливаем индекс выделенного элемента
                            _selectedIndex = index;
                          });
                        },
                        child: ListTile(
                          minLeadingWidth: 8,

                          selected: index == _selectedIndex,
                          leading: SvgPicture.asset('assets/temp/kaz.svg'),
                          title: const Text(
                            'Қазақстан',
                            style: AppTextStyles.appBarTextStyle,
                          ),
                          trailing: _selectedIndex == index
                              ? SvgPicture.asset(
                                  'assets/icons/done.svg',
                                )
                              : const SizedBox(),
                        ));
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.124,
              child: Center(
                  child: DefaultButton(
                    backgroundColor: AppColors.kPrimaryColor,
                text: 'Готово',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewAuthRegisterPage()),
                  );
                },
                color: Colors.white,
                width: 343,
              )),
            )
          ],
        ),
      ),
    );
  }
}
