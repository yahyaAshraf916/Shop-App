import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/shop_state.dart';
import 'package:shop_app/shared/components/components.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouritesState,
          builder: (BuildContext context) => ListView.separated(
            itemBuilder: (context, index) => buildProductList(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data![index]
                    .product!,
                context),
            separatorBuilder: (context, index) => Divider(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  
}
