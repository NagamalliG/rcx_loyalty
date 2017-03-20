class WebhooksController < ShopifyApp::WebhooksController
 def cartsUpdate
    @success = 'success'
    render status: 200 , json: @success.to_json
 end
  def productCreate
      @success = 'success'
      
     puts request.headers["HTTP_X_SHOPIFY_SHOP_DOMAIN"]
    #   Customerdetails.connection.insert("INSERT INTO customers (id,first_name,last_name,points) VALUES (#{@id},'#{@first_name}','#{@last_name}',#{@points});")
      render status: 200 , json: @success.to_json
 end
 def customersCreate
      @id =  params[:id]
      @first_name = params[:first_name]
      @last_name = params[:last_name]
      @points = 50
      @shop_name = request.headers["HTTP_X_SHOPIFY_SHOP_DOMAIN"]
    #   puts @id 
    #   puts @first_name
    #   puts @last_name
    #   puts @points
    #   puts @shop_name
      Customerdetails.connection.insert("INSERT INTO customerdetails (id,shop_name,first_name,last_name,points) VALUES (#{@id},'#{@shop_name}','#{@first_name}','#{@last_name}',#{@points});")
      @success = 'success'
     render status: 200 , json: @success.to_json
 end
end
