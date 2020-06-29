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

String categories = r"""
                      query categories{
                        categories{
                          id
                          name
                        }
                      }
                  """;

String productID = r"""
                      query productID($id:ID){
                        product(id:$id){
                          id
                          name
                          category_id
                          stock
                          buy_price
                          sell_price
                          discount_price
                          sku
                          barcode
                          is_damaged
                          remark
                          category{
                            id
                            name
                          }
                        }
                      }
                  """;

String deleteCategory = r"""
                      mutation deleteCategory($id:ID!){
                        deleteCategory(id:$id){
                          id
                          name
                        }
                      }
                  """;

String updateCategory = r"""
                      mutation updateCategory($id:ID,$name:String){
                        updateCategory(id:$id,name:$name){
                          id
                          name
                        }
                      }
                  """;

String products = r"""
                      query products{
                        products{
                          id
                          name
                          category_id
                          stock
                          buy_price
                          sell_price
                          discount_price
                          sku
                          barcode
                          is_damaged
                          remark
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

String categoryInsert = r""" 
                        mutation categoryInsert($name:String){
                          createCategory(name:$name){
                            id
                            name
                          }
                        }
"""; 

String createProduct = r""" 
                          mutation createProduct($name:String, $category_id:Int, $stock:Int, $buy_price:Int,
                          $sell_price:Int, $discount_price:Int, $sku:String, $barcode:String, $is_damaged:Int, $remark:String){
                            createProduct(name:$name, category_id:$category_id, stock:$stock, buy_price:$buy_price,
                            sell_price:$sell_price, discount_price:$discount_price, sku:$sku, barcode:$barcode, is_damaged:$is_damaged, remark:$remark){
                              id
                              name
                              category_id
                            }
                          }
""";

String updateProduct = r""" 
                          mutation updateProduct($id:ID,$name:String, $category_id:Int, $stock:Int, $buy_price:Int,
                          $sell_price:Int, $discount_price:Int, $sku:String, $barcode:String, $is_damaged:Int, $remark:String){
                            updateProduct(id:$id,name:$name, category_id:$category_id, stock:$stock, buy_price:$buy_price,
                            sell_price:$sell_price, discount_price:$discount_price, sku:$sku, barcode:$barcode, is_damaged:$is_damaged, remark:$remark){
                              id
                              name
                              category_id
                            }
                          }
""";

String createOrder = r""" 
                      mutation createOrder($total:Int, $order_date:String, $product_id:Int, $price:Int, $qty:Int){
                        createOrder(input: {
                              total:$total,
                             order_date:$order_date,
                             orderdetails:{
                               create:[
                                 {product_id:$product_id,
                                   price:$price,
                                   qty:$qty
                                   }
                               ]
                             }
                            }){
                          id
                          total
                        }
                      }
""";