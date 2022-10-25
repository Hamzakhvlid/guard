class Pay {
  static getHourlyRate(String desc) {
    double rate = 0.0;
    switch (desc) {
      case 'Events Manag. ,Stewards,Door supervisor':
        rate = 9.5;
        break;
      case 'Key-Holding ,& Alarm Response':
        rate = 1.99;
        break;
      case 'Dog handling':
        rate = 8.21;
        break;
      case 'CCTV monitoring':
        rate = 10.0;
        break;
      case 'VIP close protection':
        rate = 29.9;
        break;
      case 'Traffic Marshal ,operative/Vehicle immobi':
        rate = 9.50;
        break;
      default:
        rate = 9.50;
    }
    return rate;
  }
}


