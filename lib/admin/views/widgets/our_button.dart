import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';

Widget ourButton({
  title,
  color = purpleColor,
  onPress,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: color,
        padding: const EdgeInsets.all(12)),
    onPressed: onPress,
    child: boldText(text: title, size: 16.0),
  );
}
