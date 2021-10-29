import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/models/brand_model.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/models/category_model.dart';
import 'package:store_app/models/order_model.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/models/user_model.dart';
import 'package:store_app/models/wishlist_model.dart';
import 'package:store_app/modules/Login_screen/cubit/cubit.dart';
import 'package:store_app/modules/brandScreens/Brand_screen.dart';
import 'package:store_app/modules/categoties_feed_screen.dart';
import 'package:store_app/modules/feeds.dart';
import 'package:store_app/modules/cart_screen.dart';
import 'package:store_app/modules/home.dart';
import 'package:store_app/modules/landingPage/landing_page.dart';
import 'package:store_app/modules/search/search_screen.dart';
import 'package:store_app/modules/user.dart';
import 'package:store_app/network/local/cache_helper.dart';
import 'package:store_app/shared/components/components.dart';
import 'package:store_app/shared/constants/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class StoreAppCubit extends Cubit<StoreAppStates> {
  StoreAppCubit() : super(StoreAppInitialState());

  static StoreAppCubit get(context) => BlocProvider.of(context);
  int selectedIndex = 0;
  var pages = [
    {
      'page': HomeScreen(),
      'title': 'Home Screen',
    },
    {
      'page': FeedsScreen(),
      'title': 'Feeds Screen',
    },
    {
      'page': SearchScreen(),
      'title': 'SearchScreen',
    },
    {
      'page': CartScreen(),
      'title': 'Cart Screen',
    },
    {
      'page': UserScreen(),
      'title': 'User Screen',
    },
  ];

  void selectedPage(int index) {
    selectedIndex = index;
    emit(StoreAppBottomBarChangeState());
  }

  void selectedSearch() {
    selectedIndex = 2;
    emit(StoreAppBottomBarSearchState());
  }

  void selectedHome() {
    selectedIndex = 0;
    emit(StoreAppBottomBarHomeState());
  }

  bool isDark = false;

  void changeThemeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }

  void changeThemeModeToDark({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = true;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }

  void changeThemeModeToLight({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = false;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }
  ///////////////loginScreen
  void userLogin({
    @required String password,
    @required String email,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password).then((value){
      getUserData();
      getOrders();
      print(value.user.email);
      print(value.user.uid);
      emit(LoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityState());
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name;
  String phone;
  String email;
  String uId;
  String profileImage;
  String address;
  String joinedAt;
  String createdAt;
  void getUserData() async {
    emit(GetUserLoginLoadingStates());
    User user = _auth.currentUser;
    uId = user.uid;
    print('user.displayName ${user.displayName}');
    print('user.photoURL ${user.photoURL}');
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uId).get();
    if (userDoc == null) {
      return;
    } else {
      name = userDoc.get('name');
      email = user.email;
      joinedAt = userDoc.get('joinedAt');
      phone = userDoc.get('phone');
      address = userDoc.get('address');
      profileImage = userDoc.get('profileImage');
      createdAt = userDoc.get('createdAt');
      emit(GetUserLoginSuccessStates());
    }
  }
  List<OrderModel> orders = [];
  void getOrders() async {
    emit(GetOrdersLoadingStates());
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uId)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      orders.clear();
      ordersSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        orders.insert(
          0,
          OrderModel(
            orderId: element.get('orderId'),
            title: element.get('title'),
            price: element.get('price'),
            imageUrl: element.get('imageUrl'),
            userId: element.get('userId'),
            userAddress: element.get('userAddress'),
            total: element.get('total'),
            subTotal: element.get('subTotal'),
            anotherNumber: element.get('anotherNumber'),
            addressDetails: element.get('addressDetails'),
            quantity: element.get('quantity'),
            productId: element.get('productId'),
            username: element.get('username'),
            userPhone: element.get('userPhone'),
          ),
        );
      });
      emit(GetOrdersSuccessStates());
    }).catchError((error) {
      emit(GetOrdersErrorStates());
    });
  }
  /////////
  List<Product> popularProducts = [];

  Product findById(String productId) {
    return products.firstWhere((element) => element.id == productId);
  }

  List<Product> findByCategory(String categoryName) {
    List categoryList = products
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoryList;
  }

  List<Product> findByBrand(String brandName) {
    List categoryList = products
        .where((element) =>
            element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return categoryList;
  }

  Map<String, CartModel> cartItem = {};

  Map<String, CartModel> get getCartItems {
    return {...cartItem};
  }
  double get totalAmount {
    var total = 0.0;
    cartItem.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }
 var uuid = Uuid();
  void uploadItemToCart({
     String productId,
     String title,
     double price,
     String imageUrl,
     String userId,
     int quantity,
}) {
    final cartId=uuid.v4();
    FirebaseFirestore.instance
        .collection('carts')
        .doc(cartId)
        .set({
      'productId': productId,
      'userId': uId,
      'cartId': cartId,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity;': 1,
    }).then((value) {
      emit(CreateCartItemSuccessState());
    }).catchError((error) {
      emit(CreateCartItemErrorState());
    });
  }

  void addProductToCart(
      final String productId,
      final String title,
      final double price,
      final String imageUrl,
      ) {
    if (cartItem.containsKey(productId)) {
      cartItem.update(
          productId,
              (existingCartItem) => CartModel(
            title: existingCartItem.title,
            imageUrl: existingCartItem.imageUrl,
            price: existingCartItem.price,
            id: existingCartItem.id,
            quantity: existingCartItem.quantity + 1,
          ));
    } else {
      cartItem.putIfAbsent(
          productId,
              () => CartModel(
            title: title,
            imageUrl: imageUrl,
            price: price,
            id: DateTime.now().toString(),
            quantity: 1,
          ));
    }
    emit(StoreAppAddToCartSuccessState());
  }
  void reduceItemByOne(
      final String productId,
      final String title,
      final double price,
      final String imageUrl,
      ) {
    if (cartItem.containsKey(productId)) {
      cartItem.update(
          productId,
              (existingCartItem) => CartModel(
            title: existingCartItem.title,
            imageUrl: existingCartItem.imageUrl,
            price: existingCartItem.price,
            id: existingCartItem.id,
            quantity: existingCartItem.quantity - 1,
          ));
    }
    emit(StoreAppReduceCartItemByOneSuccessState());
  }
  void removeItem(
      final String productId,
      ) {
    cartItem.remove(productId);
    emit(StoreAppRemoveCartItemSuccessState());
  }

  void clearCart() {
    cartItem.clear();
    emit(StoreAppClearCartSuccessState());
  }

  /////////////////////////
  Map<String, WishListModel> wishListItem = {};

  Map<String, WishListModel> get getWishListItem {
    return {...wishListItem};
  }

  void addOrRemoveFromWishList(
    final String productId,
    final String title,
    final double price,
    final String imageUrl,
  ) {
    if (wishListItem.containsKey(productId)) {
      removeItemFromWishList(productId);
    } else {
      wishListItem.putIfAbsent(
          productId,
          () => WishListModel(
                title: title,
                imageUrl: imageUrl,
                price: price,
                id: DateTime.now().toString(),
              ));
    }
    emit(StoreAppAddItemToWishListSuccessState());
  }

  void removeItemFromWishList(
    final String productId,
  ) {
    wishListItem.remove(productId);
    emit(StoreAppRemoveWishListItemSuccessState());
  }

  void clearWishList() {
    wishListItem.clear();
    emit(StoreAppClearWishListSuccessState());
  }

  List<Product> searchList = [];

  List<Product> searchQuery(String searchText) {
    searchList = products
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    emit(StoreAppSearchQuerySuccessState());
    return searchList;
  }



  List<Product> products = [];

  void getProduct() async {
    emit(GetProductLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      products = [];
      productsSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        products.insert(
          0,
          Product(
              id: element.get('id'),
              title: element.get('title'),
              description: element.get('description'),
              price: double.parse(
                element.get('price'),
              ),
              imageUrl: element.get('imageUrl'),
              brand: element.get('brand'),
              productCategoryName: element.get('productCategoryName'),
              isPopular: true),
        );
      });
      emit(GetProductSuccessStates());
    }).catchError((error) {
      emit(GetProductErrorStates());
    });
  }
//////////////////////////// orderScreen
  /*List<OrderModel> orders = [];
  void getOrders(context) async {
    emit(GetOrdersLoadingStates());
    await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: LoginCubit.get(context).uId)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      orders.clear();
      ordersSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        orders.insert(
          0,
          OrderModel(
              orderId: element.get('orderId'),
              title: element.get('title'),
              price: element.get('price'),
              imageUrl: element.get('imageUrl'),
              userId: element.get('userId'),
              userAddress: element.get('userAddress'),
              total: element.get('total'),
              subTotal: element.get('subTotal'),
              anotherNumber: element.get('anotherNumber'),
              addressDetails: element.get('addressDetails'),
              quantity: element.get('quantity'),
              productId: element.get('productId'),
              username: element.get('username'),
              userPhone: element.get('userPhone'),
          ),
        );
      });
      emit(GetOrdersSuccessStates());
    }).catchError((error) {
      emit(GetOrdersErrorStates());
    });
  }*/


  ///////////////////////////////////Signout
  void signOut(context) => CacheHelper.removeData(key: 'uId').then((value) {
        if (value) {
          FirebaseAuth.instance
              .signOut()
              .then((value) => navigateAndFinish(context, LandingPage()));
          emit(SignOutSuccessState());
        }
      });
  ////////////////////////////////categoryScreen
  List<CategoryModel> categories = [
    CategoryModel(
        categoryName: 'phones',
        categoryImage: 'assets/images/CatPhones.png'),
    CategoryModel(
        categoryName: 'headphones',
        categoryImage: 'assets/images/headphone.jpg'),
    CategoryModel(
        categoryName: 'charger', categoryImage: 'assets/images/charger.jpg'),
    CategoryModel(
        categoryName: 'used', categoryImage: 'assets/images/mobil.jpg'),
    CategoryModel(
        categoryName: 'mobile', categoryImage: 'assets/images/mobilat.jpg'),
    CategoryModel(
        categoryName: 'cable', categoryImage: 'assets/images/cable.jpg'),
    CategoryModel(
        categoryName: 'watches',
        categoryImage: 'assets/images/CatWatches.jpg'),
    CategoryModel(
        categoryName: 'memory',
        categoryImage: 'assets/images/memory.png'),
    CategoryModel(
        categoryName: 'cover', categoryImage: 'assets/images/cover.jpeg'),
    CategoryModel(
        categoryName: 'screen',
        categoryImage: 'assets/images/screen.jpeg'),
    CategoryModel(
        categoryName: 'tablet', categoryImage: 'assets/images/tablet.jpg'),
    CategoryModel(
        categoryName: 'powerbank', categoryImage: 'assets/images/power.jpg'),
    CategoryModel(
        categoryName: 'computer', categoryImage: 'assets/images/computer.jpg'),
  ];

  Widget buildCategoryItem(context, CategoryModel category) => InkWell(
    onTap: () {
      navigateTo(
          context,
          CategoriesFeedScreen(
            categoryName: category.categoryName,
          ));
    },
    child: Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xff37475A).withOpacity(0.2),
            blurRadius: 20.0,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: AssetImage(
              category.categoryImage,
            ),
            fit: BoxFit.fill,
            height: 150,
            width: 150,
          ),
          Container(
              height: 30,
              width: 150,
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Text(
                  category.categoryName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    ),
  );

  // BrandScreen
  Widget buildPopularBrandsItem(BrandModel brand, context) => InkWell(
    onTap: () {
      selectedBrandIndex = brand.id;
      if (brand.id == 0) {
        brandName = 'redmi';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 1) {
        brandName = 'Apple';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 2) {
        brandName = 'lenovo';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 3) {
        brandName = 'oppo';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 4) {
        brandName = 'realme';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 5) {
        brandName = 'Samsung';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 6) {
        brandName = 'Huawei';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 7) {
        brandName = 'nokia';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 8) {
        brandName = 'nokia';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 9) {
        brandName = 'sony';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 10) {
        brandName = 'vivo';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 11) {
        brandName = 'tecno';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 12) {
        brandName = 'infnix';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 13) {
        brandName = 'itel';
        brandList = findByBrand(brandName);
      }
      if (brand.id == 14) {
        brandList = products;
      }
      navigateTo(context, BrandScreen());
      emit(OnTapBrandItemState());
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.blueGrey,
        child: Image.asset(
          brand.brandImage,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
  List<BrandModel> brands = [
    BrandModel(
      brand: 'redmi',
      brandImage: 'assets/images/redmi.png',
      id: 0,
    ),
    BrandModel(
      brand: 'Apple',
      brandImage: 'assets/images/apple.jpg',
      id: 1,
    ),
    BrandModel(
      brand: 'lenovo',
      brandImage: 'assets/images/lenovo.png',
      id: 2,
    ),
    BrandModel(
      brand: 'oppo',
      brandImage: 'assets/images/oppo.png',
      id: 3,
    ),
    BrandModel(
      brand: 'realme',
      brandImage: 'assets/images/realme.png',
      id: 4,
    ),
    BrandModel(
      brand: 'Samsung',
      brandImage: 'assets/images/samsung.jpg',
      id: 5,
    ),
    BrandModel(
      brand: 'Huawei',
      brandImage: 'assets/images/Huawei.jpg',
      id: 6,
    ),
    BrandModel(
      brand: 'nokia',
      brandImage: 'assets/images/nokia.jpg',
      id: 7,
    ),
    BrandModel(
      brand: 'sony',
      brandImage: 'assets/images/sony.jpg',
      id: 8,
    ),
    BrandModel(
      brand: 'vivo',
      brandImage: 'assets/images/vivo.jpg',
      id: 9,
    ),
    BrandModel(
      brand: 'tecno',
      brandImage: 'assets/images/tecno.png',
      id: 10,
    ),
    BrandModel(
      brand: 'infnix',
      brandImage: 'assets/images/infinix.jpg',
      id: 11,
    ),
    BrandModel(
      brand: 'itel',
      brandImage: 'assets/images/itel.jpg',
      id: 12,
    ),
  ];
  int selectedBrandIndex = 0;
  String brandName;
  var brandList = [];

  void changeIndex(int index) {
    selectedBrandIndex = index;
    if (selectedBrandIndex == 0) {
      brandName = 'redmi';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 1) {
      brandName = 'Apple';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 2) {
      brandName = 'lenovo';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 3) {
      brandName = 'oppo';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 4) {
      brandName = 'realme';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 5) {
      brandName = 'Samsung';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 6) {
      brandName = 'Huawei';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 7) {
      brandName = 'nokia';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 8) {
      brandName = 'sony';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 9) {
      brandName = 'vivo';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 10) {
      brandName = 'tecno';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 11) {
      brandName = 'infnix';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 12) {
      brandName = 'itel';
      brandList = findByBrand(brandName);
    }
    if (selectedBrandIndex == 13) {
      brandList = products;
    }
    emit(ChangeIndexState());
  }

  final padding = 8.0;

  NavigationRailDestination buildRotatedTextRailDestination(
      String text, double padding) {
    return NavigationRailDestination(
      icon: SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(text),
        ),
      ),
    );
  }
/*List<Product> products = [
    Product(
        id: 'Samsung1',
        title: 'Samsung Galaxy S9',
        description:
            'Samsung Galaxy S9 G960U 64GB Unlocked GSM 4G LTE Phone w/ 12MP Camera - Midnight Black',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Phones',
        isPopular: false),
    Product(
        id: 'Samsung Galaxy A10s',
        title: 'Samsung Galaxy A10s',
        description:
            'Samsung Galaxy A10s A107M - 32GB, 6.2" HD+ Infinity-V Display, 13MP+2MP Dual Rear +8MP Front Cameras, GSM Unlocked Smartphone - Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg',
        brand: 'Samsung ',
        productCategoryName: 'Phones',
        isPopular: false),
    Product(
        id: 'Samsung Galaxy A51',
        title: 'Samsung Galaxy A51',
        description:
            'Samsung Galaxy A51 (128GB, 4GB) 6.5", 48MP Quad Camera, Dual SIM GSM Unlocked A515F/DS- Global 4G LTE International Model - Prism Crush Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61HFJwSDQ4L._AC_SL1000_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Phones',
        isPopular: true),
    Product(
        id: 'Huawei P40 Pro',
        title: 'Huawei P40 Pro',
        description:
            'Huawei P40 Pro (5G) ELS-NX9 Dual/Hybrid-SIM 256GB (GSM Only | No CDMA) Factory Unlocked Smartphone (Silver Frost) - International Version',
        price: 900.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/6186cnZIdoL._AC_SL1000_.jpg',
        brand: 'Huawei',
        productCategoryName: 'Phones',
        isPopular: true),
    Product(
        id: 'iPhone 12 Pro',
        title: 'iPhone 12 Pro',
        description:
            'New Apple iPhone 12 Pro (512GB, Gold) [Locked] + Carrier Subscription',
        price: 1100,
        imageUrl: 'https://m.media-amazon.com/images/I/71cSV-RTBSL.jpg',
        brand: 'Apple',
        productCategoryName: 'Phones',
        isPopular: true),
    Product(
        id: 'iPhone 12 Pro Max ',
        title: 'iPhone 12 Pro Max ',
        description:
            'New Apple iPhone 12 Pro Max (128GB, Graphite) [Locked] + Carrier Subscription',
        price: 50.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71XXJC7V8tL._FMwebp__.jpg',
        brand: 'Apple',
        productCategoryName: 'Phones',
        isPopular: false),
    Product(
        id: 'Hanes Mens ',
        title: 'Long Sleeve Beefy Henley Shirt',
        description: 'Hanes Men\'s Long Sleeve Beefy Henley Shirt ',
        price: 22.30,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
        brand: 'No brand',
        productCategoryName: 'Clothes',
        isPopular: true),
    Product(
        id: 'Weave Jogger',
        title: 'Weave Jogger',
        description: 'Champion Mens Reverse Weave Jogger',
        price: 58.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
        brand: 'H&M',
        productCategoryName: 'Clothes',
        isPopular: false),
    Product(
        id: 'Adeliber Dresses for Womens',
        title: 'Adeliber Dresses for Womens',
        description:
            'Adeliber Dresses for Womens, Sexy Solid Sequined Stitching Shining Club Sheath Long Sleeved Mini Dress',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
        brand: 'H&M',
        productCategoryName: 'Clothes',
        isPopular: true),
    Product(
        id: 'Tanjun Sneakers',
        title: 'Tanjun Sneakers',
        description:
            'NIKE Men\'s Tanjun Sneakers, Breathable Textile Uppers and Comfortable Lightweight Cushioning ',
        price: 191.89,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71KVPm5KJdL._AC_UX500_.jpg',
        brand: 'Nike',
        productCategoryName: 'Shoes',
        isPopular: false),
    Product(
        id: 'Training Pant Female',
        title: 'Training Pant Female',
        description: 'Nike Epic Training Pant Female ',
        price: 189.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61jvFw72OVL._AC_UX466_.jpg',
        brand: 'Nike',
        productCategoryName: 'Clothes',
        isPopular: false),
    Product(
        id: 'Trefoil Tee',
        title: 'Trefoil Tee',
        description: 'Originals Women\'s Trefoil Tee ',
        price: 88.88,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51KMhoElQcL._AC_UX466_.jpg',
        brand: 'Addidas',
        productCategoryName: 'Clothes',
        isPopular: true),
    Product(
        id: 'Long SleeveWoman',
        title: 'Long Sleeve woman',
        description: ' Boys\' Long Sleeve Cotton Jersey Hooded T-Shirt Tee',
        price: 68.29,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71lKAfQDUoL._AC_UX466_.jpg',
        brand: 'Addidas',
        productCategoryName: 'Clothes',
        isPopular: false),
    Product(
        id: 'Eye Cream for Wrinkles',
        title: 'Eye Cream for Wrinkles',
        description:
            'Olay Ultimate Eye Cream for Wrinkles, Puffy Eyes + Dark Circles, 0.4 fl oz',
        price: 54.98,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61dwB-2X-6L._SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Beauty & health',
        isPopular: false),
    Product(
        id: 'Mango Body Yogurt',
        title: 'Mango Body Yogurt',
        description:
            'The Body Shop Mango Body Yogurt, 48hr Moisturizer, 100% Vegan, 6.98 Fl.Oz',
        price: 80.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81w9cll2RmL._SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Beauty & health',
        isPopular: false),
    Product(
        id: 'Food Intensive Skin',
        title: 'Food Intensive Skin',
        description:
            'Weleda Skin Food Intensive Skin Nourishment Body Butter, 5 Fl Oz',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71E6h0kl3ZL._SL1500_.jpg',
        brand: 'No Brand',
        productCategoryName: 'Beauty & health',
        isPopular: true),
    Product(
        id: 'Ultra Shea Body Cream',
        title: 'Ultra Shea Body Cream',
        description:
            'Bath and Body Works IN THE STARS Ultra Shea Body Cream (Limited Edition) 8 Ounce ',
        price: 14,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61RkTTLRnNL._SL1134_.jpg',
        brand: '',
        productCategoryName: 'Beauty & health',
        isPopular: false),
    Product(
        id: 'Soft Moisturizing Crème',
        title: 'Soft Moisturizing Crème',
        description:
            'NIVEA Soft Moisturizing Crème- Pack of 3, All-In-One Cream For Body, Face and Dry Hands - Use After Hand Washing - 6.8 oz. Jars',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/619pgKveCdL._SL1500_.jpg',
        brand: 'No Brand',
        productCategoryName: 'Beauty & health',
        isPopular: true),
    Product(
        id: 'Body Cream Cocoa Butter',
        title: 'Body Cream Cocoa Butter',
        description: 'NIVEA Cocoa Butter Body Cream 15.5 Oz',
        price: 84.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61EsS5sSaCL._SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Beauty & health',
        isPopular: true),
    Product(
        id: 'Skin Repair Body Lotion',
        title: 'Skin Repair Body Lotion',
        description:
            'O\'Keeffe\'s Skin Repair Body Lotion and Dry Skin Moisturizer, Pump Bottle, 12 ounce, Packaging May Vary',
        price: 890.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71e7ksQ-xyL._AC_SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Beauty & health',
        isPopular: false),
    Product(
        id: '15 5000 Laptop',
        title: '15 5000 Laptop',
        description:
            'Dell Inspiron 15 5000 Laptop Computer: Core i7-8550U, 128GB SSD + 1TB HDD, 8GB RAM, 15.6-inch Full HD Display, Backlit Keyboard, Windows 10 ',
        price: 630.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/31ZSymDl-YL._AC_.jpg',
        brand: 'Dell',
        productCategoryName: 'Laptops',
        isPopular: true),
    Product(
        id: 'Business Laptop',
        title: 'Business Laptop',
        description:
            'Latest Dell Vostro 14 5490 Business Laptop 14.0-Inch FHD 10th Gen Intel Core i7-10510U Up to 4.9 GHz 16GB DDR4 RAM 512GB M.2 PCIe SSD GeForce MX250 2GB GDDR5 GPU Fingerprint Reader Type-C Win10 Pro ',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71W690nu%2BXL._AC_SL1500_.jpg',
        brand: 'Dell',
        productCategoryName: 'Laptops',
        isPopular: true),
    Product(
        id: 'Latitude 5411 14" Notebook',
        title: 'Latitude 5411 14" Notebook',
        description:
            'Latitude 5411 14" Notebook - Full HD - 1920 x 1080 - Core i7 i7-10850H 10th Gen 2.7GHz Hexa-core (6 Core) - 16GB RAM - 256GB SSD',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/41OfZx5ex3L._AC_.jpg',
        brand: 'Dell',
        productCategoryName: 'Laptops',
        isPopular: false),
    Product(
        id: 'New Apple MacBook Pro with Apple',
        title: 'New Apple MacBook Pro with Apple',
        description:
            'New Apple MacBook Pro with Apple M1 Chip (13-inch, 8GB RAM, 256GB SSD Storage) - Space Gray (Latest Model)',
        price: 800.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71an9eiBxpL._AC_SL1500_.jpg',
        brand: 'Apple',
        productCategoryName: 'Laptops',
        isPopular: true),
    Product(
        id: 'Apple MacBook Air',
        title: 'Apple MacBook Air',
        description:
            'Apple MacBook Air 13.3" with Retina Display, 1.1GHz Quad-Core Intel Core i5, 16GB Memory, 256GB SSD, Space Gray (Early 2020)',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61wLbRLshAL._AC_SL1200_.jpg',
        brand: 'Apple',
        productCategoryName: 'Laptops',
        isPopular: true),
    Product(
        id: 'Apple MacBook Progag',
        title: 'Apple MacBook Pro',
        description:
            'Apple MacBook Pro MF839LL/A 13.3in Laptop, Intel Core i5 2.7 GHz, 8GB Ram, 128GB SSD ',
        price: 700.89,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/315CQ1KmlwL._AC_.jpg',
        brand: 'Apple',
        productCategoryName: 'Laptops',
        isPopular: false),
    Product(
        id: 'Apple MacBook Air',
        title: 'Apple MacBook Air',
        description:
            'Apple MacBook Air 13.3" with Retina Display, 1.1GHz Quad-Core Intel Core i5, 8GB Memory, 256GB SSD, Silver (Early 2020)',
        price: 780.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61QRQHn0jJL._AC_SL1200_.jpg',
        brand: 'Apple',
        productCategoryName: 'Laptops',
        isPopular: true),
    Product(
        id: 'Apple 16 MacBook Pro',
        title: 'Apple 16 MacBook Pro',
        description:
            'Apple 16 MacBook Pro with Touch Bar, 9th-Gen 8-Core Intel i9 2.3GHz, 16GB RAM, 1TB SSD, AMD Radeon Pro 5500M 8GB, Space Gray, Late 2019 Z0Y0005J7 / Z0Y00006M',
        price: 800.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61qNHbx9LDL._AC_SL1200_.jpg',
        brand: 'Apple',
        productCategoryName: 'Laptops',
        isPopular: false),
    Product(
        id: 'Sofa Setttt',
        title: 'Sofa Set',
        description: 'Beverly Fine Funiture Sectional Sofa Set, 91A Black ',
        price: 650.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71P-p2sj6eL._AC_SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Furniture',
        isPopular: true),
    Product(
        id: 'Furniture Classroom with Teacher\'s',
        title: 'Furniture Classroom with Teacher\'s',
        description:
            'L.O.L. Surprise! Furniture Classroom with Teacher\'s Pet & 10+ Surprises',
        price: 120.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71xytsyiHzL._AC_SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Furniture',
        isPopular: false),
    Product(
        id: 'Sofa Couch for Two People',
        title: 'Sofa Couch for Two People',
        description:
            'Serta Copenhagen Sofa Couch for Two People, Pillowed Back Cushions and Rounded Arms, Durable Modern Upholstered Fabric, 61" Loveseat, Brown',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81sBT3voCPL._AC_SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Furniture',
        isPopular: true),
    Product(
        id: 'Delta Children Plastic Toddler Bed',
        title: 'Delta Children Plastic Toddler Bed',
        description:
            'Delta Children Plastic Toddler Bed, Disney Princess + Delta Children Twinkle Galaxy Dual Sided Recycled Fiber Core Toddler Mattress (Bundle)',
        price: 127.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71Rj3InxQlL._SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Furniture',
        isPopular: false),
    Product(
        id: 'Outdoor Patio ',
        title: 'Outdoor Patio ',
        description:
            'Recaceik 3 Pieces Outdoor Patio Furniture Sets Rattan Chair Wicker Set, with Cushions and Tempered Glass Tabletop, Outdoor Indoor Use Backyard Porch Garden-(Brown)',
        price: 1224.88,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81KabJxRvDL._AC_SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Furniture',
        isPopular: true),
    Product(
        id: 'Flash Furniture Nantucket 6 Piece',
        title: 'Flash Furniture Nantucket 6 Piece',
        description:
            'Flash Furniture Nantucket 6 Piece Black Patio Garden Set with Table, Umbrella and 4 Folding Chairs',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81khjDZg5xL._AC_SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Furniture',
        isPopular: false),
    Product(
        id: 'Homall 4 Pieces Patio Outdoor Furniture Sets',
        title: 'Homall 4 Pieces Patio Outdoor Furniture Sets',
        description:
            'Homall 4 Pieces Patio Outdoor Furniture Sets, All Weather PE Rattan Wicker Sectional Sofa Modern Manual Conversation Sets with Cushions and Glass Table for Lawn Backyard Garden Poolside（Beige）',
        price: 1220.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/716-fllmUCL._AC_SL1500_.jpg',
        brand: 'No brand',
        productCategoryName: 'Furniture',
        isPopular: true),
    Product(
        id: 'Ashley Furniture Signature Design',
        title: 'Ashley Furniture Signature Design',
        description:
            'Ashley Furniture Signature Design - Dolante Upholstered Bed - Queen Size - Complete Bed Set in a Box - Contemporary Style Checker - Gray',
        price: 300.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71QxxtRFFkL._AC_SL1232_.jpg',
        brand: 'No brand',
        productCategoryName: 'Furniture',
        isPopular: false),
    Product(
        id: 'Apple Watch Series 3',
        title: 'Apple Watch Series 3',
        description:
            'Apple Watch Series 3 (GPS, 38mm) - Silver Aluminum Case with White Sport Band',
        price: 100.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71vCuRn4CkL._AC_SL1500_.jpg',
        brand: 'Apple',
        productCategoryName: 'Watches',
        isPopular: true),
    Product(
        id: 'Garmin Forerunner 45S',
        title: 'Garmin Forerunner 45S',
        description:
            'Garmin Forerunner 45S, 39mm Easy-to-use GPS Running Watch with Coach Free Training Plan Support, Purple',
        price: 86.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51EWl3XsiYL._AC_SL1000_.jpg',
        brand: 'No brand',
        productCategoryName: 'Watches',
        isPopular: false),
    Product(
        id: 'Samsung Galaxy Watch Active 2',
        title: 'Samsung Galaxy Watch Active 2',
        description:
            'Samsung Galaxy Watch Active 2 (40mm, GPS, Bluetooth) Smart Watch with Advanced Health Monitoring, Fitness Tracking , and Long Lasting Battery - Silver (US Version)',
        price: 300.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51bSW9gjoaL._AC_SL1024_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Watches',
        isPopular: false),
    Product(
        id: 'Garmin vivoactive 4S',
        title: 'Garmin vivoactive 4S',
        description:
            'Garmin vivoactive 4S, Smaller-Sized GPS Smartwatch, Features Music, Body Energy Monitoring, Animated Workouts, Pulse Ox Sensors, Rose Gold with White Band',
        price: 40.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51r2LCE3FLL._AC_SL1000_.jpg',
        brand: 'No brand',
        productCategoryName: 'Watches',
        isPopular: false),
    Product(
        id: 'Patek Philippe World',
        title: 'Patek Philippe World',
        description: 'Patek Philippe World Time Men\'s Watch Model 5131/1P-001',
        price: 20.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61MVdCYfbOL._AC_UX679_.jpg',
        brand: 'No brand',
        productCategoryName: 'Watches',
        isPopular: false),
    Product(
        id: 'Bell & Ross Men',
        title: 'Bell & Ross Men',
        description:
            'Bell & Ross Men\'s BR-MNUTTOURB-PG Minuteur\' Black Carbon Fiber Dial 18K Rose Gold Tourbillon Watch',
        price: 33.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91M50AHRTKL._AC_UX569_.jpg',
        brand: 'No brand',
        productCategoryName: 'Watches',
        isPopular: false),
    Product(
        id: 'New Apple Watch Series',
        title: 'New Apple Watch Series',
        description:
            'New Apple Watch Series 6 (GPS, 40mm) - Blue Aluminum Case with Deep Navy Sport Band ',
        price: 400.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71bf9IpGjtL._AC_SL1500_.jpg',
        brand: 'Apple',
        productCategoryName: 'Watches',
        isPopular: false),
    Product(
        id: 'New Apple Watch SE',
        title: 'New Apple Watch SE',
        description:
            'New Apple Watch SE (GPS, 40mm) - Gold Aluminum Case with Pink Sand Sport Band',
        price: 200.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71JtUMDeBBL._AC_SL1500_.jpg',
        brand: 'Apple',
        productCategoryName: 'Watches',
        isPopular: false),
    Product(
        id: 'YAMAY Smart Watch 2020 Ver',
        title: 'YAMAY Smart Watch 2020 Ver',
        description:
            'YAMAY Smart Watch 2020 Ver. Watches for Men Women Fitness Tracker Blood Pressure Monitor Blood Oxygen Meter Heart Rate Monitor IP68 Waterproof, Smartwatch Compatible with iPhone Samsung Android Phones',
        price: 183.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61gCtkVYb5L._AC_SL1000_.jpg',
        brand: 'Apple',
        productCategoryName: 'Watches',
        isPopular: true),
    Product(
        id: 'Samsung Galaxy Watch Active 23',
        title: 'Samsung Galaxy Watch Active ',
        description:
            'Samsung Galaxy Watch Active (40MM, GPS, Bluetooth) Smart Watch with Fitness Tracking, and Sleep Analysis - Rose Gold  (US Version)',
        price: 150.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61n1c2vnPJL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Watches',
        isPopular: true),
    Product(
        id: 'Samsung Galaxy Watch 3',
        title: 'Samsung Galaxy Watch 3',
        description:
            'Samsung Galaxy Watch 3 (41mm, GPS, Bluetooth) Smart Watch with Advanced Health monitoring, Fitness Tracking , and Long lasting Battery - Mystic Silver (US Version)',
        price: 184.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81Iu41zFPwL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Watches',
        isPopular: true),
    Product(
        id: 'Samsung Galaxy Watch Active2 ',
        title: 'Samsung Galaxy Watch Active2 ',
        description:
            'Samsung Galaxy Watch Active2 (Silicon Strap + Aluminum Bezel) Bluetooth - International (Aqua Black, R820-44mm)',
        price: 120.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/518qjbbuGZL._AC_SL1000_.jpg',
        brand: 'Samsung',
        productCategoryName: 'Watches',
        isPopular: false),
    Product(
        id: 'Huawei Watch 2 Sport Smartwatch',
        title: 'Huawei Watch 2 Sport Smartwatch',
        description:
            'Huawei Watch 2 Sport Smartwatch - Ceramic Bezel - Carbon Black Strap (US Warranty)',
        price: 180.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71yPa1g4gWL._AC_SL1500_.jpg',
        brand: 'Huawei',
        productCategoryName: 'Watches',
        isPopular: true),
  ];*/
}
