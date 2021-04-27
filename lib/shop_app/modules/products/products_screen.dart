import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_cubit.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_states.dart';
import 'package:udemy_flutter/shop_app/models/home/categories_model.dart';
import 'package:udemy_flutter/shop_app/models/home/home_model.dart';
import 'package:udemy_flutter/shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition:
              shopCubit.homeModel != null && shopCubit.categoriesModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => _productsBuilder(
            context: context,
            homeModel: shopCubit.homeModel,
            categoriesModel: shopCubit.categoriesModel,
          ),
        );
      },
    );
  }

  Widget _productsBuilder({
    @required BuildContext context,
    @required HomeModel homeModel,
    @required CategoriesModel categoriesModel,
  }) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _carouselSlider(homeModel),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerTitle('Categories'),
                _categoriesList(categoriesModel.data.data),
                _headerTitle('New Products'),
              ],
            ),
          ),
          _gridView(homeModel),
        ],
      ),
    );
  }

  Widget _categoriesList(List<CategoryModel> categoriesList) {
    return Container(
      height: 100,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => _categoryItem(categoriesList[index]),
        separatorBuilder: (context, index) => SizedBox(
          width: 5,
        ),
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _headerTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
    );
  }

  Widget _categoryItem(CategoryModel categoryModel) {
    return Card(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(categoryModel.image),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              categoryModel.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridView(HomeModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1 / 1.58,
        children: List.generate(
          model.data.products.length,
          (index) => _productItem(model.data.products[index]),
        ),
      ),
    );
  }

  Widget _productItem(ProductModel model) {
    // print('${model.name} - ${model.image}');
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Center(
                child: Image(
                  image: NetworkImage(model.image),
                  height: 200,
                ),
              ),
              if (model.discount > 0)
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          height: 1.3,
                          color: defaultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount > 0)
                        Text(
                          '${model.oldPrice}',
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
                        icon: Icon(
                          Icons.favorite_border,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
