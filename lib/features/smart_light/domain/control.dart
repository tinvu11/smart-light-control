class Control {
  final String doSangCuaDen;
  final String nutDoiMau;
  final String nutNguon;
  final String nutTuDongSang;

  Control({
    required this.doSangCuaDen,
    required this.nutDoiMau,
    required this.nutNguon,
    required this.nutTuDongSang,
  });

  factory Control.fromJson(Map<String, dynamic> json) {
    return Control(
      doSangCuaDen: json['doSangCuaDen'] ?? '',
      nutDoiMau: json['nutDoiMau'] ?? '',
      nutNguon: json['nutNguon'] ?? '',
      nutTuDongSang: json['nutTuDongSang'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'doSangCuaDen': doSangCuaDen,
    'nutDoiMau': nutDoiMau,
    'nutNguon': nutNguon,
    'nutTuDongSang': nutTuDongSang,
  };
}
