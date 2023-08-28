import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/features/app/widgets/custom_cupertino_action_sheet.dart';
import 'package:haji_market/features/basket/presentation/widgets/show_alert_edit_widget.dart';

import '../../../drawer/data/bloc/address_cubit.dart';

Future<dynamic> showAlertEditDestroyWidget(
    BuildContext context, int id, country, city, street, home, floor, porch, room) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CustomCupertinoActionSheet(
      actions: <Widget>[
        CustomCupertinoActionSheetAction(
          child: const Row(
            children: [
              Icon(
                Icons.create,
                color: Colors.red,
                size: 24.0,
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 270,
                child: Text(
                  'Редактировать',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          onPressed: () {
            // GetStorage().write('basket_address_box', 1);
            // Navigator.pop(context);
            showAlertEditWidget(context, id, country, city, street, home, floor, porch, room);
          },
        ),
        CustomCupertinoActionSheetAction(
          child: const Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
                size: 24.0,
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 270,
                child: Text(
                  'Удалить',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          onPressed: () async {
            print('delete');
            await BlocProvider.of<AddressCubit>(context).delete(id);
            Navigator.pop(context);
            // showAlertAddWidget(context, product);
          },
        ),
      ],
      cancelButton: CustomCupertinoActionSheetAction(
        child: const Text(
          'Отмена',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
