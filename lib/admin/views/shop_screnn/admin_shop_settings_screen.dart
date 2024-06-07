import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:e_commerce_app/admin/views/widgets/custom_textfield.dart';

import 'package:flutter/material.dart';

class AdminShopSettings extends StatelessWidget {
  const AdminShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: shopSettings, size: 16.0),
        actions: [TextButton(onPressed: () {}, child: normalText(text: save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customtextField(label: shopName, hint: nameHint),
            10.heightBox,
            customtextField(label: address, hint: shopAddressHint),
            10.heightBox,
            customtextField(label: mobile, hint: shopMobileHint),
            10.heightBox,
            customtextField(label: website, hint: shopwebSiteHint),
            10.heightBox,
            customtextField(
                label: description, hint: shopDescHint, isDesc: true),
          ],
        ),
      ),
    );
  }
}
