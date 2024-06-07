import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';

Widget adminProductDropdown() {
  return DropdownButtonHideUnderline(
    child: DropdownButton<String>(
        hint: normalText(text: "Choose Category", color: fontGrey),
        value: null,
        isExpanded: true,
        items: const [],
        onChanged: (value) {}),
  )
      .box
      .white
      .padding(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .make();
}
