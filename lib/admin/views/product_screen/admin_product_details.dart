import 'package:e_commerce_app/admin/const/const.dart';
import 'package:e_commerce_app/admin/views/widgets/normal_text.dart';
import 'package:get/get.dart';

class AdminProductDetails extends StatelessWidget {
  final dynamic data;

  const AdminProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkFontGrey,
            )),
        title: boldText(text: "${data['p_name']}", size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //vxswiper section
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                itemCount: data['p_imgs'].length,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.network(
                    data["p_imgs"][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  //title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                  boldText(
                      text: "${data['p_name']}", color: fontGrey, size: 16.0),

                  10.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: fontGrey,
                          size: 16.0),
                      10.widthBox,
                      boldText(
                          text: "${data['p_subcategory']}",
                          color: fontGrey,
                          size: 16.0),
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                ],
              ),
            ),
            10.heightBox,
            //"Rs.${data['p_price']}".text.color(redColor).fontFamily(bold).size(18).make(),
            boldText(
                text: "Rs.${data['p_price']}", color: redColor, size: 16.0),
            10.heightBox,
            //Color section
            20.heightBox,
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: "Colors".text.color(textfieldGrey).make(),
                    ),
                    Row(
                      children: List.generate(
                        3,
                        (index) => VxBox()
                            .size(40, 40)
                            .roundedFull
                            //.color(Color(data['p_colors'][index]).withOpacity(1.0))
                            .color(Vx.randomPrimaryColor)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .make()
                            .onTap(() {
                          //controller.changeColorIndex(index);
                        }),
                      ),
                    ),
                  ],
                ),
                10.heightBox,

                //Quantity Row
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: boldText(text: "Quantity", color: fontGrey),
                    ),
                    normalText(
                      text: "${data['p_quantity']}",
                      color: fontGrey,
                    )
                  ],
                ),
              ],
            ).box.white.padding(const EdgeInsets.all(8)).make(),
            const Divider(),
            20.heightBox,
            boldText(text: "Description", color: fontGrey),
            10.heightBox,
            normalText(text: "${data['p_desc']}", color: fontGrey),

            //button section
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
