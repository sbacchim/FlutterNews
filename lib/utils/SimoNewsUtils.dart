class SimoNewsUtils {

  //Method by DiegoPerego
  static String getArticleDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime actualDate = DateTime.now();

    Duration endDate = actualDate.difference(dateTime);

    int finalDate;
    if (endDate.inDays != 0) {
      finalDate = endDate.inDays;
      if (finalDate == 1)
        return finalDate.toString() + 'Ieri';
      else
        return finalDate.toString() + ' giorni fa';
    } else if (endDate.inHours != 0) {
      finalDate = endDate.inHours;
      if (finalDate == 1)
        return finalDate.toString() + ' ora fa';
      else
        return finalDate.toString() + ' ore fa';
    } else if (endDate.inMinutes != 0) {
      finalDate = endDate.inMinutes;
      if (finalDate == 1)
        return finalDate.toString() + ' minuto fa';
      else
        return finalDate.toString() + ' minuti fa';
    } else if (endDate.inSeconds != 0) {
      finalDate = endDate.inMinutes;
      if (finalDate == 1)
        return finalDate.toString() + ' secondo fa';
      else
        return finalDate.toString() + ' secondi fa';
    }
    return "";
  }
}