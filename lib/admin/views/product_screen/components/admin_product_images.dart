import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';

Widget adminProductImages({
  required label,
  onPress,
}) {
  return "$label"
      .text
      .bold
      .size(16.0)
      .makeCentered()
      .color(lightGrey)
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
