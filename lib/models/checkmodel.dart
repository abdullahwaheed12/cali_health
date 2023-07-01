// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum GapDuration {
  afterAYear,
  onceInLifeTime,
  afterTwoYear,
  afterThreeYears,
  afterTenYears,
  afterSixMonth
}

class CheckUpmodel {
  String checkUpName;
  bool isDone;
  bool isSkip;
  DateTime? dueDate;
  GapDuration gapDuration;

  CheckUpmodel({
    required this.checkUpName,
    required this.isDone,
    required this.isSkip,
    required this.dueDate,
    required this.gapDuration,
  });

  CheckUpmodel copyWith({
    String? checkUpName,
    bool? isDone,
    bool? isSkip,
    DateTime? dueDate,
    GapDuration? gapDuration,
  }) {
    return CheckUpmodel(
      checkUpName: checkUpName ?? this.checkUpName,
      isDone: isDone ?? this.isDone,
      isSkip: isSkip ?? this.isSkip,
      dueDate: dueDate ?? this.dueDate,
      gapDuration: gapDuration ?? this.gapDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'checkUpName': checkUpName,
      'isDone': isDone,
      'isSkip': isSkip,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'gapDuration': gapDuration.toString(),
    };
  }

  factory CheckUpmodel.fromMap(Map<String, dynamic> map) {
    return CheckUpmodel(
      checkUpName: map['checkUpName'] as String,
      isDone: map['isDone'] as bool,
      isSkip: map['isSkip'] as bool,
      dueDate: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'])
          : null,
      gapDuration: GapDuration.values.firstWhere(
          (element) => map['gapDuration'].toString() == element.toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckUpmodel.fromJson(String source) =>
      CheckUpmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Checkmodel(checkUpName: $checkUpName, isDone: $isDone, isSkip: $isSkip,, dueDate: $dueDate, gapDuration: $gapDuration)';
  }

  @override
  int get hashCode {
    return checkUpName.hashCode ^
        isDone.hashCode ^
        isSkip.hashCode ^
        dueDate.hashCode ^
        gapDuration.hashCode;
  }

  @override
  bool operator ==(covariant CheckUpmodel other) {
    if (identical(this, other)) return true;

    return other.checkUpName == checkUpName &&
        other.isDone == isDone &&
        other.isSkip == isSkip &&
        other.dueDate == dueDate &&
        other.gapDuration == gapDuration;
  }
}
