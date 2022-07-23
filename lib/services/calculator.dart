import 'package:cloud_firestore/cloud_firestore.dart';
//*Formatlama işlemlerinde kullanılıyor. DateTime nesnesinin formatını ayarlayabilmek için import ettik.
import 'package:intl/intl.dart';

class Calculator {
  /// DateTime zaman biçimini --> Stringe formatlayıp çeviren
  static String dateTimeToString(DateTime dateTime) {
    String formattedDate = DateFormat('dd/ MM/ yyyy').format(dateTime);
    return formattedDate;
  }

  /// DateTime --> TimeStamp
  static Timestamp datetimeToTimestamp(DateTime dateTime) {
//*Normalde direk datetime'ı çevirme var ama sıkıntı çıktığı için miliseconds formatından çevirdik. Belki düzelmiş olabilir denemek lazım.
    return Timestamp.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
  }

  /// TimeStamp --> DateTime
//*Normalde direk datetime'ı çevirme var ama sıkıntı çıktığı için miliseconds formatından çevirdik. Belki düzelmiş olabilir denemek lazım.

  static DateTime datetimeFromTimestamp(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  }
}
