import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_state.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/shop_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottomIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<dynamic, dynamic> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error.toString()));
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessHomeCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }

  ChangeFavorites? changefavorites;
  void changeFavorites(productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changefavorites = ChangeFavorites.fromJason(value.data);

      if (!changefavorites!.status!) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changefavorites!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavouritesState(error.toString()));
    });
  }

  ShopLoginModel? userModel;
  void getuserdata() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  void updateuserdata({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {'name':name, "email": email, "phone": phone},
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      
      
      emit(ShopSuccessUpdateUserDataState(userModel!));
      
    }).catchError((error) {
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }
}
