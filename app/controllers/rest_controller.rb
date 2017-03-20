require 'rest-client'
class RestController < ShopifyApp::AuthenticatedController
 def getTierSvc
     response = RestClient.get 'https://nameless-escarpment-97840.herokuapp.com/tiers'
     @restData =response.body 
    #  puts response.body
     render json: @restData
 end
 def getProgramsSvc
     @tier_id=request.query_string
    #   puts @tier_id
      response = RestClient.get 'https://nameless-escarpment-97840.herokuapp.com/programs?'+@tier_id
      @restData = response.body 
    #   puts response.body
      render json: @restData
 end
 def getLevelsSvc
    #  puts "called..."
     @program_id=request.query_string
    #  puts @program_id
      response = RestClient.get 'https://nameless-escarpment-97840.herokuapp.com/levels?'+@program_id
      @restData = response.body 
    #   puts response.body
      render json: @restData
 end
 def getPoints
     puts "getPoints called..."
     @customer_id=request.query_string
     @id= @customer_id.split("=").last
     @points = Customerdetails.where(:id => @id)
     puts @points
     render json: @customer_id
 end
end
