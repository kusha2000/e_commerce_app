import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:e_commerce_app/widgets_common/our_button.dart';

class LoginScreenAdmin extends StatelessWidget {
  const LoginScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 80,
                    height: 80,
                  )
                      .box
                      .border(color: whiteColor)
                      .rounded
                      .padding(EdgeInsets.all(8.0))
                      .make(),
                  10.widthBox,
                  boldText(text: appname, size: 18.0),
                ],
              ),
              40.heightBox,
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: emailHint),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: passwordHint),
                  ),
                  10.heightBox,
                  30.heightBox,
                  SizedBox(
                    width: context.screenWidth - 100,
                    child: ourButton(title: login, onPress: () {}),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .outerShadowMd
                  .padding(EdgeInsets.all(8.0))
                  .make(),
              10.heightBox,
              Center(child: normalText(text: anyProblem)),
              Spacer(),
              Center(child: boldText(text: credit))
            ],
          ),
        ),
      ),
    );
  }
}
