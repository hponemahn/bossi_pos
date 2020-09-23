class Businesscat {
  String id;
  String name;

  getid() => this.id;
  getName() => this.name;

  setId(String value) {
    this.id = value;
  }

  setName(String value) {
    this.name = value;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

