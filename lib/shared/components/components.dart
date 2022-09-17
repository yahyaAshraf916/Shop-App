import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.maxFinite,
  Color backgroundColor = Colors.blue,
  bool isUpperCase = true,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      color: backgroundColor,
      child: ElevatedButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text),
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget defulteditTextx({
  required TextEditingController Controller,
  required TextInputType keyboardType,
  GestureTapCallback? onTap,
  required FormFieldValidator<String> validator,
  required String Label,
  required IconData prefix,
  IconData? suffix,
  bool? isPassword = false,
  Function? suffixPressed()?,
  Function? onchanged(value)?,
  Function? onSubmitted(value)?,
}) =>
    TextFormField(
      onTap: onTap,
      obscureText: isPassword!,
      controller: Controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmitted,
      onChanged: onchanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: Label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) => false,
    );
void showToast({
  required text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  SUCCSESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCSESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
  }
  return color;
}

Widget buildProductList(model, context, {bool isOldPrice = true}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: CachedNetworkImageProvider(model.image!),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    color: Colors.red,
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3, fontSize: 14),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "${model.price!.round()}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: defaultcolor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          "${model.oldPrice!.round()}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      if (isOldPrice)
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                ShopCubit.get(context).favorites[model.id]
                                    ? defaultcolor
                                    : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
