import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_cubit.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_states.dart';
import 'package:udemy_flutter/shop_app/models/home/favorites_model.dart';
import 'package:udemy_flutter/shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopToggleFavoriteSucessState) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
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
              _buildFavoritesList(shopCubit.favoritesModel.data.data),
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
      itemBuilder: (context, index) => _buildFavouriteItem(
        context: context,
        model: favoritesList[index],
      ),
      itemCount: favoritesList.length,
    );
  }

  Widget _buildFavouriteItem({
    @required BuildContext context,
    @required FavoriteModel model,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          height: 120,
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(8),
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Center(
                      child: Image(
                        image: NetworkImage(model.product.image),
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // if (model.discount > 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.product.name, //model.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product.price}',
                          style: TextStyle(
                            height: 1.3,
                            color: defaultColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.product.discount > 0)
                          Text(
                            '${model.product.oldPrice}',
                            style: TextStyle(
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context)
                                    .favorites[model.product.id]
                                ? defaultColor
                                : Colors.grey,
                            radius: 15,
                            child: Center(
                              child: Icon(
                                Icons.favorite_border,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorite(model.product.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
