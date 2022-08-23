// ignore_for_file: public_member_api_docs, sort_constructors_first
class TypeImage {
  final String? alt;
  final String? caption;
  final bool? primary;
  final String? filename;
  
  TypeImage({
    this.alt,
    this.caption,
    this.primary,
    this.filename,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'alt': alt,
      'caption': caption,
      'primary': primary,
      'filename': filename,
    };
  }

  factory TypeImage.fromJson(Map<String, dynamic> map) {
    return TypeImage(
      alt: map['alt'] != null ? map['alt'] as String : null,
      caption: map['caption'] != null ? map['caption'] as String : null,
      primary: map['primary'] != null ? map['primary'] as bool : null,
      filename: map['filename'] != null ? map['filename'] as String : null,
    );
  }

  @override
  String toString() {
    return 'TypeImage(alt: $alt, caption: $caption, primary: $primary, filename: $filename)';
  }
}
