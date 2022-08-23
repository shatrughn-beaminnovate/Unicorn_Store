// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class PrimaryProductDetails {
  final int? id;
  final String? name;
  final String? slug;
  final String? images;
  final int? parent_id;
  final int? category_id;

  PrimaryProductDetails(this.id, this.name, this.slug, this.images,
      this.parent_id, this.category_id);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'images': images,
      'parent_id': parent_id,
      'category_id': category_id,
    };
  }

  factory PrimaryProductDetails.fromJson(Map<String, dynamic> map) {
    return PrimaryProductDetails(
      map['id'] != null ? map['id'] as int : null,
      map['name'] != null ? map['name'] as String : null,
      map['slug'] != null ? map['slug'] as String : null,
      map['images'] != null ? map['images'] as String : null,
      map['parent_id'] != null ? map['parent_id'] as int : null,
      map['category_id'] != null ? map['category_id'] as int : null,
    );
  }

  @override
  String toString() {
    return 'PrimaryProductDetails(id: $id, name: $name, slug: $slug, images: $images, parent_id: $parent_id, category_id: $category_id)';
  }
}
