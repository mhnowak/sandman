import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  final int id;
  final String title;
  final String description;
  final String imageUrl;

  @override
  List<Object?> get props => [id, title, description, imageUrl];

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
