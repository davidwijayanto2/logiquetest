import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logique_techtest/models/detail_user.dart';
import 'package:logique_techtest/repositories/api_request.dart';
import 'package:logique_techtest/repositories/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class DetailUserProvider extends ChangeNotifier {
  DetailUser? _detailUser;
  bool? _isFetching = false;
  bool? _isFriend = false;

  DetailUser? get detailUser => _detailUser;
  bool? get isFetching => _isFetching;
  bool? get isFriend => _isFriend;

  setDetailUser(value) {
    _detailUser = value;
    notifyListeners();
  }

  setIsFetching(value) {
    _isFetching = value;
    notifyListeners();
  }

  Future addFriend(id) async {
    Database db = await DBHelper.instance.database;
    await db.insert("friend", {'id': id}).then((value) {
      _isFriend = true;
      notifyListeners();
    });
  }

  Future removeFriend(id) async {
    Database db = await DBHelper.instance.database;
    await db.delete("friend", where: "id = ?", whereArgs: [id]).then((value) {
      _isFriend = false;
      notifyListeners();
    });
  }

  checkUser(id) async {
    Database db = await DBHelper.instance.database;
    var result = await db.rawQuery("SELECT * FROM friend WHERE id = ?", [id]);
    print(result);
    if (result.isNotEmpty) {
      _isFriend = true;
      notifyListeners();
    }
  }

  Future getDetailUser({required id}) async {
    _isFetching = true;
    await APIRequest().getDetailUser(id: id).then((value) {
      if (value != null) {
        print(value);
        _detailUser = DetailUser.fromJsonMap(value);
      }
      _isFetching = false;
      notifyListeners();
    }).catchError((error) {
      _isFetching = false;
      print(error);
    });
  }
}
