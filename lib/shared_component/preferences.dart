import 'package:shared_preferences/shared_preferences.dart';
const String uidKey="uidKey";
 String? uidValue="";

class AppPreferences{
final SharedPreferences _sharedPreferences ;
AppPreferences(this._sharedPreferences);


void setUid(String uid)async{
 await _sharedPreferences.setString(uidKey, uid);
}
 String? getUid(){
 uidValue= _sharedPreferences.getString(uidKey);
 return uidValue;
}
}