import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_cubit.dart';
import 'package:udemy_flutter/shop_app/models/home/home_model.dart';
import 'package:udemy_flutter/shop_app/modules/login/shop_login_screen.dart';
import 'package:udemy_flutter/shop_app/shared/network/local/shop_cache_helper.dart';
import 'package:udemy_flutter/shop_app/shared/styles/colors.dart';

void navigateTo(
  BuildContext context,
  Widget widget,
) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToReplacement(
  BuildContext context,
  Widget widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required VoidCallback onPressed,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  ValueChanged<String> onSubmit,
  ValueChanged<String> onChange,
  bool isPassword = false,
  @required String Function(String) validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  VoidCallback suffixPressed,
  VoidCallback onTap,
  bool readOnly = false,
  TextCapitalization textCapitalization = TextCapitalization.sentences,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Future<bool> showToast({
  @required String message,
  @required Color backgroundColor,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );

void signOut(BuildContext context) =>
    ShopCacheHelper.removeData(key: 'token').then(
      (value) {
        if (value) {
          navigateToReplacement(context, ShopLoginScreen());
        }
      },
    );

Widget buildPrdouctListItem({
  @required BuildContext context,
  @required ProductModel product,
  bool showFav = true,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Container(
        height: 120,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(8),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Center(
                    child: Image(
                      image: NetworkImage(product.image),
                      height: 120,
                      width: 120,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  if (product.discount > 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name, //model.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(height: 1.3),
                  ),
                  Spacer(),
                  if (showFav) _showFavRow(product, context),
                  if (!showFav) _notShowFavRow(product, context),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _showFavRow(ProductModel product, BuildContext context) {
  return Row(
    children: [
      Text(
        '${product.price}',
        style: TextStyle(
          height: 1.3,
          color: defaultColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        width: 5,
      ),
      if (product.discount > 0)
        Text(
          '${product.oldPrice}',
          style: TextStyle(
            height: 1.3,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
            decorationColor: Colors.red,
          ),
        ),
      Spacer(),
      IconButton(
        padding: EdgeInsets.zero,
        icon: CircleAvatar(
          backgroundColor: ShopCubit.get(context).favorites[product.id]
              ? defaultColor
              : Colors.grey,
          radius: 15,
          child: Center(
            child: Icon(
              Icons.favorite_border,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: () {
          ShopCubit.get(context).changeFavorite(product.id);
        },
      ),
    ],
  );
}

Widget _notShowFavRow(ProductModel product, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(
          'After discount if exists: ${product.price}',
          style: TextStyle(
            height: 1.3,
            color: defaultColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        if (product.discount > 0)
          Text(
            '${product.oldPrice}',
            style: TextStyle(
              height: 1.3,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.red,
            ),
          ),
        Spacer(),
      ],
    ),
  );
}
