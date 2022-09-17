import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessHomeCategoriesState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {
  String error;
  ShopErrorCategoriesDataState(this.error);
}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavorites model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {
  String error;
  ShopErrorChangeFavoritesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates {}
class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {
  String error;
  ShopErrorGetFavouritesState(this.error);
}
class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {
  String error;
  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopErrorUpdateUserDataState extends ShopStates {
  String error;
  ShopErrorUpdateUserDataState(this.error);
}
