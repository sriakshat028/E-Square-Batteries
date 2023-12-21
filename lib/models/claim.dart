class Claim {
  final String serial, vehicle, customer, mobile, model, date, warranty, reason;
  Claim({
    required this.serial,
    required this.vehicle,
    required this.customer,
    required this.mobile,
    required this.model,
    required this.date,
    required this.warranty,
    required this.reason,
  });

  static Map<String, String> toMap(Claim claim) {
    return {
      'serial': claim.serial,
      'vehicle': claim.vehicle,
      'customer': claim.customer,
      'mobile': claim.mobile,
      'model': claim.model,
      'date': claim.date,
      'warranty': claim.warranty,
      'reason': claim.reason,
    };
  }

  static Claim fromMap(Map map) {
    return Claim(
      serial: map['serial'],
      vehicle: map['vehicle'],
      customer: map['customer'],
      mobile: map['mobile'],
      model: map['model'],
      date: map['date'],
      warranty: map['warranty'],
      reason: map['reason'],
    );
  }
}
