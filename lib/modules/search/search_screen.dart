import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/shop_search_cubit.dart';
import 'package:shop_app/modules/search/cubit/shop_search_state.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defulteditTextx(
                        Controller: searchController,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "search not be empty";
                          }
                          return null;
                        },
                        Label: "Search",
                        prefix: Icons.search,
                        onSubmitted: (value) {
                          SearchCubit.get(context).searchData(value);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  buildProductList(
                                      SearchCubit.get(context)
                                          .searchModel?.data!.data![index],
                                      context,isOldPrice: false),
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data!
                                  .length),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  
}
