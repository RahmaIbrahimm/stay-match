/// redirectUrl : "https://accept.paymob.com/unifiedcheckout/?pub licKey=egy_pk_test_MbjHspar9gfnyQbncnmb5WOX5cyMD221&clientSecret=egy_csk_test_8843c8927a9fbef6d6e6a7715acedbf1"

class RedirectPaymentResponse {
  RedirectPaymentResponse({
      this.redirectUrl,});

  RedirectPaymentResponse.fromJson(dynamic json) {
    redirectUrl = json['redirectUrl'];
  }
  String? redirectUrl;
RedirectPaymentResponse copyWith({  String? redirectUrl,
}) => RedirectPaymentResponse(  redirectUrl: redirectUrl ?? this.redirectUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['redirectUrl'] = redirectUrl;
    return map;
  }

}