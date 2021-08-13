// import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/news_app/news_cubit.dart';
import 'package:udemy_flutter/shared/cubit/news_app/news_states.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var businessList = NewsCubit.get(context).business;

        return ScreenTypeLayout(
          mobile: Builder(
            builder: (context) {
              NewsCubit.get(context).setIsDesktop(false);
              return buildNewsList(businessList, state);
            },
          ),
          desktop: Builder(
            builder: (context) {
              NewsCubit.get(context).setIsDesktop(true);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: buildNewsList(
                      businessList,
                      state,
                    ),
                  ),
                  if (businessList.length > 0)
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            businessList[NewsCubit.get(context)
                                    .selectedBusinessIndex]['description'] ??
                                'There is no description',
                          ),
                        ),
                      ),
                    )
                ],
              );
            },
          ),
          breakpoints: ScreenBreakpoints(
            desktop: 700,
            watch: 100,
            tablet: 400,
          ),
        );
      },
    );
  }
}
