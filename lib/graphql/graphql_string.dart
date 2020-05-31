String userInfo = r"""
                      query userInfo{
                        users{
                          id
                          name
                          email
                          remember_token
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
                        businesscat{
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
                            remember_token

                          }
                        }
                    """; 

String simpleSingup=r"""
                        mutation simpleSingup($name:String,$business_name:String,$business_cat_id: String,
                        $phone: String,$email:String,$password:String,$township_id: Int,$state_id: Int,$address: String){
                          signup(
                            name:$name
                            business_name:$business_name
                            business_cat_id: $business_cat_id
                            phone:$phone
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
                        mutation gmailSingup($name:String,$business_name:String,$business_cat_id: String,
                        $phone: String,$email:String,$township_id: Int,$state_id: Int,$address: String,$remember_token:String){
                          gmail_signup(
                            name:$name
                            business_name:$business_name
                            business_cat_id: $business_cat_id
                            phone:$phone
                            email:$email
                            township_id: $township_id
                            state_id: $state_id
                            address: $address
                            remember_token : $remember_token 
                           
                          ){
                            id
                            name
                            email
                            remember_token
                          }
                        }
                      """; 