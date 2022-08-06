import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logique_techtest/models/user.dart';
import 'package:logique_techtest/repositories/api_request.dart';

class HomeProvider extends ChangeNotifier {
  int? _totalData;
  PagingController<int, User> _userPagingController =
      PagingController(firstPageKey: 1);
  int _currentPage = 1;

  int? get totalData => _totalData;
  PagingController<int, User> get userPagingController => _userPagingController;
  int get currentPage => _currentPage;

  setTotalData(value) {
    _totalData = value;
    notifyListeners();
  }

  setCurrentPage(value) {
    _currentPage = value;
    notifyListeners();
  }

  Future getDataUser({page}) async {
    await APIRequest().getUser().then((value) {
      if (value != null) {
        List<User> listUser =
            List<User>.from(value['data'].map((map) => User.fromJsonMap(map)));
        _totalData = value['total'] ?? 0;
        if ((page * 20) < _totalData) {
          _currentPage++;
          _userPagingController.appendPage(listUser, _currentPage);
        } else {
          _userPagingController.appendLastPage(listUser);
        }

        notifyListeners();
      } else {
        _userPagingController.appendLastPage(<User>[]);
      }
    }).catchError((error) {
      print(error);
    });
  }
}
