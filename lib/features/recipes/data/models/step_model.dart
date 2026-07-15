class Step {
  final int id;
  final int sectionId;
  final String description;
  final int orderIndex;

  const Step({
    required this.id,
    required this.sectionId,
    required this.description,
    required this.orderIndex,
  });

  factory Step.fromMap(Map<String, dynamic> map) {
    return Step(
      id: map['id'] as int,
      sectionId: map['section_id'] as int,
      description: map['description'] as String? ?? '',
      orderIndex: map['order_index'] as int? ?? 0,
    );
  }
}
