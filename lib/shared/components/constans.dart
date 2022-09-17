import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

void signOut(context) {
  CachHelper.removeData(key: "token").then((value) {
    if (value) {
      navigateTo(context, ShopLoginScreen());
    }
  });
}



String ?token;
