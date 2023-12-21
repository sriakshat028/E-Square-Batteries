class Feedback {
  String serial, dealer, location, warranty, saledate, reason;
  Feedback({
    required this.serial,
    required this.dealer,
    required this.location,
    required this.warranty,
    required this.saledate,
    required this.reason,
  });

  static Map<String, String> toMap(Feedback feedback) {
    return {
      'serial': feedback.serial,
      'dealer': feedback.dealer,
      'location': feedback.location,
      'warranty': feedback.warranty,
      'saledate': feedback.saledate,
      'reason': feedback.reason,
    };
  }

  static Feedback fromMap(Map map) {
    return Feedback(
      serial: map['serial'],
      dealer: map['dealer'],
      location: map['location'],
      warranty: map['warranty'],
      saledate: map['saledate'],
      reason: map['reason'],
    );
  }
}
