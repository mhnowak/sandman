import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_product_model.g.dart';

@JsonSerializable()
class CreateProductModel extends Equatable {
  const CreateProductModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory CreateProductModel.fromJson(Map<String, dynamic> json) => _$CreateProductModelFromJson(json);

  final String title;
  final String description;
  final String imageUrl;

  @override
  List<Object?> get props => [title, description, imageUrl];

  Map<String, dynamic> toJson() => _$CreateProductModelToJson(this);
}
