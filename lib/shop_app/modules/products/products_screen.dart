import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_cubit.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_states.dart';
import 'package:udemy_flutter/shop_app/models/home/home_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: shopCubit.model != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => _productsBuilder(
            context: context,
            model: shopCubit.model,
          ),
        );
      },
    );
  }

  Widget _productsBuilder({
    @required BuildContext context,
    @required HomeModel model,
  }) {
    return Column(
      children: [
        _carouselSlider(model),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  CarouselSlider _carouselSlider(HomeModel model) {
    return CarouselSlider(
      items: _bannersList(model),
      options: CarouselOptions(
        enableInfiniteScroll: true,
        initialPage: 0,
        viewportFraction: 1,
        height: 250,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  List<Widget> _bannersList(HomeModel model) {
    return model.data.banners.map((item) {
      return Image(
        image: NetworkImage(item.image),
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }).toList();
  }
}
