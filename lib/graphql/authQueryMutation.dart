class AuthQueryMutation {
  String singUp(
    String name,
    int roleID,
    String businessName,
    String businessCatID,
    String phone,
    String email,
    String password,
    int townshipID,
    int stateID,
    String address) {
  return """
          mutation {
                signup(
                  name:"$name"
                  role_id:$roleID
                  business_name:"$businessName"
                  business_cat_id: "$businessCatID"
                  phone:"$phone"
                  email:"$email"
                  password : "$password"
                  township_id: $townshipID
                  state_id: $stateID
                  address: "$address"
                  
                ){
                  id
                  name
                  email
                  api_token
                }
            } 
  """;
}

String roles() {
  return """ 
       {
        roles{
          id
          name
          display_name
        }
      }
    """;
}

String states() {
  return """
        {
          states{
            id
            name
          }
        }
  """;
}

String township(int stateId) {
  return """ 
       {
        townships(state_id: $stateId){
          id
          name
          
        }
      }
    """;
}

String login(String email, String phone, String password) {
  return """ 
  mutation {
            login (email :"$email"
                  phone :"$phone"
                  password :"$password")
              {
              id
              name
              remember_token
              api_token

            }
          }
  """;
}

}