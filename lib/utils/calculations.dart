import '../models/checkmodel.dart';

List<CheckUpmodel> getCalculations(int age, String gender) {
  List<CheckUpmodel> checkUps = [];
  //----abdullah logic---------
  //----both M and F
  if (age >= 18 && age <= 35) {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Allgemeiner Gesundheits-Check-Up',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.onceInLifeTime));
  } else if (age >= 35) {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Allgemeiner Gesundheits-Check-Up zur Früherkennung von z.B. Nieren-, Herz-Kreislauferkrankungen und Diabetes',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterThreeYears));
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Screening auf eine Hepatitis B- und Hepatitis C-Virusinfektion',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.onceInLifeTime));
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Hautkrebs-Screening',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterTwoYear));
  }
//-----only F
  if (age > 20 && gender == 'F') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Genitaluntersuchung zur Früherkennung von Gebärmutterhalskrebs',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterAYear));
  }

  if (age < 25 && gender == 'F') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Chlamydien-Screening',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterAYear));
  }
  if (age > 30 && gender == 'F') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Brustkrebsuntersuchung - Tastuntersuchung',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterAYear));
  }
  if (age >= 30 && age < 35 && gender == 'F') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Hautuntersuchung',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterAYear));
  }
  if (age > 35 && gender == 'F') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Genitaluntersuchung zur Früherkennung von Gebärmutterhalskrebs',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterThreeYears));
  }
  if (age >= 50 && age < 55 && gender == 'F') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Früherkennung von Darmkrebs auf verborgenes Blut im Stuhl',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterAYear));
  }
  if (age >= 50 && age < 69 && gender == 'F') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Brustkrebsuntersuchung – Mammographie-Screening',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterTwoYear));
  }
  if (age > 55 && gender == 'F') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Früherkennung von Darmkrebs auf verborgenes Blut im Stuhl',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterTwoYear));
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Darmspiegelungen',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterTenYears));
  }
  //--------only M
  if (age > 45 && gender == 'M') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Krebsfrüherkennungsuntersuchung der Genitalien und Prostata',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterAYear));
  }
  if (age >= 50 && age <= 54 && gender == 'M') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Früherkennung von Darmkrebs auf verborgenes Blut im Stuhl',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterAYear));
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Darmspiegelungen',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterTenYears));
  }
  if (age > 55 && gender == 'M') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName:
            'Früherkennung von Darmkrebs auf verborgenes Blut im Stuhl',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterTwoYear));
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Darmspiegelungen',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.afterTenYears));
  }
  if (age > 65 && gender == 'M') {
    checkUps.add(CheckUpmodel(
        isSkip: false,
        checkUpName: 'Screening auf Bauchaortenaneurysma',
        isDone: false,
        dueDate: null,
        gapDuration: GapDuration.onceInLifeTime));
  }
  //---kashif logic-----------
  /*
  if (gender == 'M') {
    if (age >= 18 && age <= 35) {
      checkUps.add(Checkmodel(
          checkUpName: 'Allgemeiner Gesundheits-Check-Up',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.onceInLifeTime));
    } else if (age >= 35) {
      checkUps.add(Checkmodel(
          checkUpName:
              'Allgemeiner Gesundheits-Check-Up zur Früherkennung von z.B. Nieren-, Herz-Kreislauferkrankungen und Diabetes',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterThreeYears));
      checkUps.add(Checkmodel(
          checkUpName:
              'Screening auf eine Hepatitis B- und Hepatitis C-Virusinfektion',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.onceInLifeTime));
      checkUps.add(Checkmodel(
          checkUpName: 'Hautkrebs-Screening',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterTwoYear));
    } else if (age >= 45) {
      checkUps.add(Checkmodel(
          checkUpName:
              'Krebsfrüherkennungsuntersuchung der Genitalien und Prostata',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterAYear));
    } else if (age >= 50 && age <= 54) {
      checkUps.add(Checkmodel(
          checkUpName:
              'Früherkennung von Darmkrebs auf verborgenes Blut im Stuhl',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterAYear));
      checkUps.add(Checkmodel(
          checkUpName: 'Darmspiegelungen',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterTenYears));
    } else if (age >= 55) {
      checkUps.add(Checkmodel(
          checkUpName:
              'Früherkennung von Darmkrebs auf verborgenes Blut im Stuhl',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterTwoYear));
      checkUps.add(Checkmodel(
          checkUpName: 'Darmspiegelungen',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterTenYears));
    } else if (age > 65) {
      checkUps.add(Checkmodel(
          checkUpName: 'Screening auf Bauchaortenaneurysma',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.onceInLifeTime));
    }
  } else {
    if (age >= 18 && age <= 35) {
      checkUps.add(Checkmodel(
          checkUpName: 'Allgemeiner Gesundheits-Check-Up',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.onceInLifeTime));
    } else if (age >= 20 && age < 25) {
      checkUps.add(Checkmodel(
          checkUpName:
              'Genitaluntersuchung zur Früherkennung von Gebärmutterhalskrebs',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterAYear));
    } else if (age >= 25 && age < 30) {
      checkUps.add(Checkmodel(
          checkUpName: 'Chlamydien-Screening',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterAYear));
    } else if (age >= 30 && age < 35) {
      checkUps.add(Checkmodel(
          checkUpName: 'Hautuntersuchung',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterAYear));
      checkUps.add(Checkmodel(
          checkUpName: 'Brustkrebsuntersuchung - Tastuntersuchung',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterAYear));
    } else if (age >= 35) {
      checkUps.add(Checkmodel(
          checkUpName:
              'Allgemeiner Gesundheits-Check-Up zur Früherkennung von z.B. Nieren-, Herz-Kreislauferkrankungen und Diabetes',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterThreeYears));
      checkUps.add(Checkmodel(
          checkUpName:
              'Screening auf eine Hepatitis B- und Hepatitis C-Virusinfektion',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.onceInLifeTime));
      checkUps.add(Checkmodel(
          checkUpName: 'Hautkrebs-Screening',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterTwoYear));
      checkUps.add(Checkmodel(
          checkUpName:
              'Genitaluntersuchung zur Früherkennung von Gebärmutterhalskrebs',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterThreeYears));
    } else if (age >= 50 && age < 55) {
      checkUps.add(Checkmodel(
          checkUpName:
              'Früherkennung von Darmkrebs auf verborgenes Blut im Stuhl',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterAYear));
    } else if (age >= 50 && age < 59) {
      checkUps.add(Checkmodel(
          checkUpName: 'Brustkrebsuntersuchung – Mammographie-Screening',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterTwoYear));
    } else if (age > 55) {
      checkUps.add(Checkmodel(
          checkUpName:
              'Früherkennung von Darmkrebs auf verborgenes Blut im Stuhl',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterTwoYear));
      checkUps.add(Checkmodel(
          checkUpName: 'Darmspiegelungen',
          isDone: false,
          dueDate: null,
          gapDuration: GapDuration.afterTenYears));
    }
  } */
  print('List of due Checkups is $checkUps');
  return checkUps;
}
