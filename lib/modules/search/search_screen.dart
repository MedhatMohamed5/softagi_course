import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/news_app/news_cubit.dart';
import 'package:udemy_flutter/shared/cubit/news_app/news_states.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var list = NewsCubit.get(context).search;

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: defaultFormField(
                            controller: searchController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty)
                                return 'Please enter what you want to search for';
                              return null;
                            },
                            onChange: (value) {
                              NewsCubit.get(context).getSearch(value);
                            },
                            onSubmit: (value) {},
                            label: 'Search',
                            prefix: Icons.search,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: buildNewsList(list, state),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
