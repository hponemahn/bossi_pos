String userInfo = r"""
                      query userInfo{
                        users{
                          id
                          name
                          email
                          api_token
                        }
                      }
                  """;

String systemLogin = r"""
                        mutation systemLogin($email:String,$password:String){
                          login (email :$email
                                 password :$password)
                            {
                            id
                            name
                            api_token

                          }
                        }
                    """; 

String simpleSingup=r"""
                        mutation simpleSingup($avatar:Upload,$name:String,$email:String,$password:String){
                          signup(
                            avatar:$avatar
                            name:$name
                            email:$email
                            password : $password 
                           
                          ){
                            id
                            name
                            email
                            avatar
                           
                          }
                        }
                      """; 

String gmailSingup=r"""
                        mutation gmailSingup($name:String,$email:String,$api_token:String){
                          gmail_signup(
                            name:$name
                            email:$email
                            api_token : $api_token 
                           
                          ){
                            id
                            name
                            email
                            api_token
                          }
                        }
                      """; 