import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/auth/presentation/ui/change_password.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordModalBottom extends StatefulWidget {
  final String textEditingController;
  const ForgotPasswordModalBottom(
      {required this.textEditingController, Key? key})
      : super(key: key);

  @override
  State<ForgotPasswordModalBottom> createState() =>
      _ForgotPasswordModalBottomState();
}

class _ForgotPasswordModalBottomState extends State<ForgotPasswordModalBottom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                'Введите код подтверждения,\nкоторый был отправлен по номеру\n${widget.textEditingController}',
                style: AppTextStyles.appBarTextStyle,
              ),
              SvgPicture.asset(
                'assets/icons/delete_circle.svg',
                height: 24,
                width: 24,
              ),
            ],
          ),
 const SizedBox(height:40 ,),
          SizedBox(
            width: MediaQuery.of(context).size.width,

            child: PinCodeTextField(
              length: 4,
              obscureText: false,
              keyboardType: TextInputType.phone,
              appContext: context,
              pinTheme: PinTheme(
                activeColor: Colors.grey,
                shape: PinCodeFieldShape.box,
                inactiveColor: Colors.grey,
                activeFillColor: Colors.white,
                borderRadius: BorderRadius.circular(6),
                selectedColor: Colors.green,
                fieldHeight: 48,
                fieldWidth: 48,
              ),
              onChanged: (value) {
                // log(value);
              },
              onCompleted: (value) async {
                if (value.length == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage()),
                  );
                  // final String phoneRep = widget.phoneNumber
                  //     .replaceAll(RegExp(r"[^0-9]+"), '');
                  //  BlocProvider.of<RegisterCheckSmsCubit>(
                  //   context,
                  // ).send(value, phoneRep);
                }
              },
            ),
          ),
           const Text(
                'Вы можете заново отправить код через 00:59',
                style: AppTextStyles.timerInReRegTextStyle,
              ),
              const Spacer(),
              DefaultButton(backgroundColor: AppColors.kPrimaryColor,text: 'Переотправить код', press: (){}, color: AppColors.floatingActionButton, width: MediaQuery.of(context).size.width),
              const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
