class ProxyController < ApplicationController
      include ShopifyApp::AppProxyVerification
  def index
      @customer_id= params[:id]
      # @request_hash=params[:hash]
      # @hash = Digest::MD5.hexdigest(@customer_id)
      # if @hash === @request_hash
            @controller = VerifyhmacverificationController.new
            @returnValue = @controller.check(request,params.dup)
            if @returnValue
                  @points = Customerdetails.where(:id => @customer_id)
                  # render :layout => false, status:200, :content_type => 'application/liquid'
                  render :layout => false, status:200, :content_type => 'application/html'
            else
                  render json: 'Oops, something went wrong, please go back and try again - Thanks!', status: :forbidden , :content_type => 'application/liquid'
            end
      # else
      #             render json: 'Oops, something went wrong, please go back and try again - Thanks!', status: :forbidden , :content_type => 'application/liquid'
      # end
  end
  def redeem
      @customer_id= params[:id]
      @request_hash=params[:hash]
      @hash = Digest::MD5.hexdigest(@customer_id)
      if @hash === @request_hash
      @controller = VerifyhmacverificationController.new
      @returnValue = @controller.check(request,params.dup)
      if @returnValue
            
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
            render json: 'Oops, something went wrong, please go back and try again - Thanks!', status: :forbidden , :content_type => 'application/liquid'
      end
      else
            render json: 'Oops, something went wrong, please go back and try again - Thanks!', status: :forbidden , :content_type => 'application/liquid'
      end
  end
end