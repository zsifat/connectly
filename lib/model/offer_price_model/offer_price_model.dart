class MakeOfferModel {
  final String productId;
  final String sellerId;
  final String buyerId;
  final String buyerName;
  final double bidPrice;
  final String bidTime;
  final bool isAccepted;

  MakeOfferModel(
      {required this.productId,
      required this.sellerId,
      required this.buyerId,
      required this.buyerName,
      required this.bidPrice,
      required this.bidTime,
      required this.isAccepted});

  MakeOfferModel copyWith(
      {String? productId,
      String? sellerId,
      String? buyerId,
      String? buyerName,
      double? bidPrice,
      String? bidTime,
      bool? isAccepted}) {
    return MakeOfferModel(
        productId: productId ?? this.productId,
        sellerId: sellerId ?? this.sellerId,
        buyerId: buyerId ?? this.buyerId,
        buyerName: buyerName ?? this.buyerName,
        bidPrice: bidPrice ?? this.bidPrice,
        bidTime: bidTime ?? this.bidTime,
        isAccepted: isAccepted ?? this.isAccepted);
  }

  factory MakeOfferModel.fromJson(Map<String, dynamic> json) {
    return MakeOfferModel(
        productId: json['productId'],
        sellerId: json['sellerId'],
        buyerId: json['buyerId'],
        buyerName: json['buyerName'],
        bidPrice: json['bidPrice'],
        bidTime: json['bidTime'],
        isAccepted: json['isAccepted']);
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'sellerId': sellerId,
      'buyerId': buyerId,
      'buyerName': buyerName,
      'bidPrice': bidPrice,
      'bidTime': bidTime,
      'isAccepted': isAccepted
    };
  }
}
