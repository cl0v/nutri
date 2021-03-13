

abstract class HomeScreenHelper {
  static String getDayTitle(int dayIndex, int todayIndex) {
    if (dayIndex == 1) {
      return 'AMANHÃ';
    } else if (dayIndex == -1) {
      return 'ONTEM';
    } else if (dayIndex == 0) {
      return 'HOJE';
    } else
      return getDayOfTheWeekString(dayOnTheWeekToString(todayIndex + dayIndex));
  }

  static int dayOnTheWeekToString(int dayNum) {
    if (dayNum > 7) {
      dayNum = (dayNum % 7);
    } else if (dayNum < 1) {
      dayNum = (dayNum % 7);
    }
    if (dayNum == 0) dayNum = 7;

    return dayNum;
  }

  static String getDayOfTheWeekString(int day) {
    switch (day) {
      case 1:
        return 'SEGUNDA';
      case 2:
        return 'TERÇA';
      case 3:
        return 'QUARTA';
      case 4:
        return 'QUINTA';
      case 5:
        return 'SEXTA';
      case 6:
        return 'SÁBADO';
      case 7:
        return 'DOMINGO';
      default:
        return 'HOJE';
    }
  }
}
