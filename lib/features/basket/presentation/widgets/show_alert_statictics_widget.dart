import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/statistics_page.dart';
import 'package:haji_market/features/basket/presentation/widgets/show_alert_statictics_widget%20copy.dart';
import 'package:haji_market/features/drawer/data/bloc/address_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/address_state.dart';
import '../../../../core/common/constants.dart';

Future<dynamic> showAlertAddressWidget(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Выберите адрес доставки',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: SizedBox(
            height: 270,
            child: BlocConsumer<AddressCubit, AddressState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return ListView.builder(
                      itemCount: state.addressModel.length,
                      itemBuilder: (context, int index) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                GetStorage().write('basket_address_box', index);
                                Navigator.pop(context);
                                showAlertAddressWidget(context);
                              },
                              child: Icon(
                                GetStorage().read('basket_address_box') == index
                                    ? Icons.check_circle
                                    : Icons.check_box_outline_blank,
                                color: AppColors.kPrimaryColor,
                                size: 24.0,
                              ),
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: 270,
                              child: Text(
                                '${state.addressModel[index].country}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                maxLines: 1,
                              ),
                            ),
                            // SizedBox(
                            //   height: 270,
                            //   child: ListView.builder(

                            //     itemCount: 3,
                            //     itemBuilder: (context, state) {
                            //       return
                            //     },
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);

                                showAlertEditDestroyWidget(context);
                              },
                              child: const Icon(
                                Icons.more_horiz,
                                color: AppColors.kPrimaryColor,
                                size: 24.0,
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return const CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  );
                }
              },
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StatisticsPage()),
            );
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Добавить новый адрес',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          onPressed: () {
            // showAlertAddWidget(context, product);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Выбрать',
          style: TextStyle(
              color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
