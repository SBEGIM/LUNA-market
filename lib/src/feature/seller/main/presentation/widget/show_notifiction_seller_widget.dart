import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/main/data/model/notification_seller_dto.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showNotificationSellerOptions(BuildContext context, NotificationUiModel notification) {
  showMaterialModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (context) => NotificationShowModal(notification: notification),
  );
}

class NotificationShowModal extends StatefulWidget {
  final NotificationUiModel notification;

  const NotificationShowModal({super.key, required this.notification});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationShowModalState createState() => _NotificationShowModalState();
}

class _NotificationShowModalState extends State<NotificationShowModal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${widget.notification.title}',
                    style: AppTextStyles.defaultButtonTextStyle,
                  ),
                  InkWell(onTap: () => Navigator.pop(context), child: Icon(Icons.close)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('${widget.notification.message}', style: AppTextStyles.catalogTextStyle),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
