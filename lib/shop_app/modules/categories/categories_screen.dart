import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_cubit.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_states.dart';
import 'package:udemy_flutter/shop_app/models/home/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.categoriesModel != null,
          builder: (context) =>
              _buildCategoriesList(shopCubit.categoriesModel.data.data),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  ListView _buildCategoriesList(List<CategoryModel> categoriesList) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => categoryItem(
        context: context,
        model: categoriesList[index],
      ),
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
      ),
      itemCount: categoriesList.length,
    );
  }

  Widget categoryItem({
    @required BuildContext context,
    @required CategoryModel model,
  }) =>
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                model.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      );
}
