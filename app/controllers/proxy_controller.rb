class ProxyController < ApplicationController
  def index
      puts "ProxyController called..."
      @customer_id= params[:id]
      @points = Customerdetails.where(:id => @customer_id)
      puts @customer_id
    #   puts request.headers.inspect
      render :layout => false, :content_type => 'application/liquid'
  end
  def redeem
      puts "ProxyController called..."
      @customer_id= params[:id]
    #   @points = Customerdetails.where(:id => @customer_id)
        puts @customer_id
        a = Customerdetails.find_by_id(@customer_id)
        if a.points == 0
            @status = "You don't have Any points to Redeem.."
        else
            @status = "You have successfully Redeem your "+ a.points.to_s + " points.."
            a.points = 0
            a.save   
        end  
    #   puts request.headers.inspect
      render :layout => false, :content_type => 'application/liquid'
  end
end