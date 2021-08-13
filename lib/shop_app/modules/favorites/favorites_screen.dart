import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_cubit.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_states.dart';
import 'package:udemy_flutter/shop_app/models/home/favorites_model.dart';
import 'package:udemy_flutter/shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopToggleFavoriteSucessState) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesLoadingState,
          builder: (context) =>
              _buildFavoritesList(shopCubit.favoritesModel.data!.data!),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  ListView _buildFavoritesList(List<FavoriteModel> favoritesList) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildPrdouctListItem(
        context: context,
        product: favoritesList[index].product!,
      ),
      itemCount: favoritesList.length,
    );
  }
}
