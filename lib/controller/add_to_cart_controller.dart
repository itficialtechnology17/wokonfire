import 'package:get/get.dart';
import 'package:wokonfire/controller/cart_controller.dart';
import 'package:wokonfire/controller/customization_controller.dart';
import 'package:wokonfire/controller/favorite_controller.dart';
import 'package:wokonfire/controller/home_controller.dart';
import 'package:wokonfire/controller/search_controller.dart';
import 'package:wokonfire/model/model_dashboard_title.dart';

class AddToCartController extends GetxController {
  SearchController _searchController = Get.find();
  CartController _cartController = Get.find();
  FavoriteController _favoriteController = Get.find();
  CustomizationController _customizationController = Get.find();
  HomeController _homeController = Get.find();

  var controllerType = 0.obs;
  //0=FormHomeTab
  //1=FromSearchTab
  //2=FromCart
  //3=FromFavorite
  void addToCart(int paramControllerType, int index, [int nIndex]) {
    controllerType.value = paramControllerType;
    if (controllerType.value == 0) {
      //Check Customization Available
      if (_homeController.arrOfDashboardTitle[index].foodItems[nIndex]
          .customization.isNotEmpty) {
        _customizationController.openCustomization(
            _homeController
                .arrOfDashboardTitle[index].foodItems[nIndex].finalPrice,
            _homeController
                .arrOfDashboardTitle[index].foodItems[nIndex].customization);
      } else {
        ModelDashboardTitle modelDashboardTitle =
            _homeController.arrOfDashboardTitle[index];

        modelDashboardTitle.foodItems[nIndex].fdQty =
            modelDashboardTitle.foodItems[nIndex].fdQty + 1;

        _homeController.arrOfDashboardTitle[index] = modelDashboardTitle;

        print("Item Count After Add=" +
            _homeController.arrOfDashboardTitle[index].foodItems[nIndex].fdQty
                .toString());
      }
    }
  }

  void removeFromCart(int paramControllerType, int index, [int nIndex]) {
    controllerType.value = paramControllerType;

    if (controllerType.value == 0) {
      ModelDashboardTitle modelDashboardTitle =
          _homeController.arrOfDashboardTitle[index];

      modelDashboardTitle.foodItems[nIndex].fdQty =
          modelDashboardTitle.foodItems[nIndex].fdQty - 1;

      _homeController.arrOfDashboardTitle[index] = modelDashboardTitle;

      print("Item Count After Remove =" +
          _homeController.arrOfDashboardTitle[index].foodItems[nIndex].fdQty
              .toString());
    }
  }
}
