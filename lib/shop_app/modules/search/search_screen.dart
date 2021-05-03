import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/modules/search/cubit/search_cubit.dart';
import 'package:udemy_flutter/shop_app/shared/components/components.dart';

import 'cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var searchCubit = SearchCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (value) {
                    if (value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter something to search'),
                        ),
                      );
                    } else {
                      searchCubit.search(value);
                    }
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter some thing to search";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    // labelText: 'Search',
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
              body: Column(
                children: [
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  // List of products
                  if (state is SearchSucessState)
                    _buildResultView(searchCubit, context),
                  if (state is SearchInitialState)
                    Expanded(
                      child: Center(
                        child: Text(
                          'Please Enter something to search',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultView(SearchCubit searchCubit, BuildContext context) {
    return Expanded(
      child: ConditionalBuilder(
        condition: searchCubit.searchModel.data.data.length > 0,
        builder: (context) => ListView.builder(
          itemBuilder: (context, index) => buildPrdouctListItem(
            context: context,
            product: searchCubit.searchModel.data.data[index],
            showFav: false,
          ),
          itemCount: searchCubit.searchModel.data.data.length,
        ),
        fallback: (context) => Center(
          child: Text(
            'Sorry there is no item related to your search!',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
