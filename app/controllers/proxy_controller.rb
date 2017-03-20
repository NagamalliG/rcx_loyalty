class ProxyController < ApplicationController
  def index
      @controller = VerifyhmacverificationController.new
      @returnValue = @controller.check(request,params.dup)
      if @returnValue
            @customer_id= params[:id]
            @points = Customerdetails.where(:id => @customer_id)
            render :layout => false, status:200, :content_type => 'application/liquid'
      else
            render json: '403 Forbidden....', status: :forbidden , :content_type => 'application/liquid'
       end
  end
  def redeem
      @controller = VerifyhmacverificationController.new
      @returnValue = @controller.check(request,params.dup)
      if @returnValue
            @customer_id= params[:id]
            a = Customerdetails.find_by_id(@customer_id)
            if a.points == 0
                    @status = "You don't have Any points to Redeem.."
            else
                    @status = "You have successfully Redeem your "+ a.points.to_s + " points.."
                    a.points = 0
                    a.save   
            end  
            render :layout => false, status:200, :content_type => 'application/liquid'
      else
            render json: '403 Forbidden....', status: :forbidden , :content_type => 'application/liquid'
      end
  end
end