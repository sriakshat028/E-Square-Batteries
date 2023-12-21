class Sale {
  final String model, serial, health, vehicle, customer, mobile, opt, km, date;
  Sale({
    required this.model,
    required this.serial,
    required this.health,
    required this.vehicle,
    required this.customer,
    required this.mobile,
    required this.opt,
    required this.km,
    required this.date,
  });

  static Map<String, String> toMap(Sale sale) {
    return {
      'model': sale.model,
      'serial': sale.serial,
      'health': sale.health,
      'vehicle': sale.vehicle,
      'customer': sale.customer,
      'mobile': sale.mobile,
      'opt': sale.opt,
      'km': sale.km,
      'date': sale.date
    };
  }

  static Sale fromMap(Map map) {
    return Sale(
      model: map['model'],
      serial: map['serial'],
      health: map['health'],
      vehicle: map['vehicle'],
      customer: map['customer'],
      mobile: map['mobile'],
      opt: map['opt'],
      km: map['km'],
      date: map['date'],
    );
  }
}
