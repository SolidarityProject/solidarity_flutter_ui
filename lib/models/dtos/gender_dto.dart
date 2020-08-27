class GenderDTO {
  int number;
  String description;

  GenderDTO({
    this.number,
    this.description,
  });
}

List<GenderDTO> genderList = [
  GenderDTO(number: 1, description: "Female"),
  GenderDTO(number: 2, description: "Male"),
  GenderDTO(number: 0, description: "I don't want to indicate"),
];
