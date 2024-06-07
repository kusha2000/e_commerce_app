import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';

Widget customtextField({label, hint, controller, isDesc = false}) {
  return TextFormField(
    maxLines: isDesc ? 4 : 1,
    controller: controller,
    style: const TextStyle(color: whiteColor),
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: whiteColor),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: lightGrey)),
  );
}
