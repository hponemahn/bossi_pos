class AuthQueryMutation {
  String register(
      {String name,
      String phone,
      String email,
      String password,
      int bType,
      int state,
      int township}) {
    print("graphQL received data");
    print("name: $name");
    print("email: $email");
    print("password: $password");
    print("phone: $phone");

    return """
              mutation {
                register(
                      name: "$name"
                      device_id: ""
                      logo: "logo"
                      email: "$email"
                      password: "$password"
                      business_cat_id: "1"
                      state_id: 1
                      township_id: 1
                  )
              }
    """;
  }

  String login({String phoneEmail, String password}) {
    print("graphQL received data");
    print("email: $phoneEmail");
    print("password: $password");

    return """
              mutation {
                login (email: "$phoneEmail", password: "$password")
              }
    """;
  }
}
