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

String checkEmail = r"""
                      query checkEmail($email:String){
                        emailuser(email :$email){
                          id
                          name
                          email
                        }
                      }
                  """;

String category = r"""
                      query category{
                        cateories{
                          id
                          name
                        }
                      }
                  """;

String states = r"""
                      query states{
                        states{
                          id
                          name
                        }
                      }
                  """;

String townships = r"""
                      query townships{
                        townships{
                          id
                          name
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
                        mutation simpleSingup($name:String,$shop_name:String,$cat_id: String,
                        $ph: String,$email:String,$password:String,$township_id: Int,$state_id: Int,$address: String){
                          signup(
                            name:$name
                            shop_name:$shop_name
                            cat_id: $cat_id
                            ph:$ph
                            email:$email
                            password : $password 
                            township_id: $township_id
                            state_id: $state_id
                            address: $address
                           
                          ){
                            id
                            name
                            email
                            
                          }
                        }
                      """; 

String gmailSingup=r"""
                        mutation gmailSingup($name:String,$shop_name:String,$cat_id: String,
                        $ph: String,$email:String,$township_id: Int,$state_id: Int,$address: String,$api_token:String){
                          gmail_signup(
                            name:$name
                            shop_name:$shop_name
                            cat_id: $cat_id
                            ph:$ph
                            email:$email
                            township_id: $township_id
                            state_id: $state_id
                            address: $address
                            api_token : $api_token 
                           
                          ){
                            id
                            name
                            email
                            api_token
                          }
                        }
                      """; 