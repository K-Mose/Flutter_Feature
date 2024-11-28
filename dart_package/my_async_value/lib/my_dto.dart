/// JSON 형식 공통 DTO
///
class DTO {
  DTO({
    required Map<String, dynamic>? content,
  }) : _content = content;

  Map<String, dynamic>? _content;

  factory DTO.fromJson(Map<String, dynamic> json) => DTO(content: json);

  Map<String, dynamic> get json => _content ?? {};

  @override
  String toString() {
    return 'DTO{content: $_content}';
  }
}