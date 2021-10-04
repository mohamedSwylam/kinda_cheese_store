import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/layout/cubit/states.dart';
import 'package:store_app/modules/cart.dart';
import 'package:store_app/modules/feeds.dart';
import 'package:store_app/modules/home.dart';
import 'package:store_app/modules/search.dart';
import 'package:store_app/modules/user.dart';
import 'package:store_app/network/local/cache_helper.dart';

class StoreAppCubit extends Cubit<StoreAppStates> {
  StoreAppCubit() : super(StoreAppInitialState());

  static StoreAppCubit get(context) => BlocProvider.of(context);
  int selectedIndex =0;
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
}