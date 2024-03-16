import 'package:equatable/equatable.dart';

final class SubmitServiceDetailsCart extends Equatable {
  final int id;
  final String paymentUrl;

  const SubmitServiceDetailsCart({this.id = 0, this.paymentUrl = ""});

  SubmitServiceDetailsCart copyWith({
    int? id,
    String? paymentUrl,
  }) {
    return SubmitServiceDetailsCart(
      id: id ?? this.id,
      paymentUrl: paymentUrl ?? this.paymentUrl,
    );
  }

  @override
  List<Object> get props => [id, paymentUrl];
}
