class HomeController < ShopifyApp::AuthenticatedController
 def getTiers
      @tiers = Tiers.all
      render json: @tiers
    #   log(request.body.read)
 end
 def getPrograms
     #@programs = Programs.all(:tier => 'tier1')
      @selectedData=params['tier']
      @programs = Programs.where(:tier => @selectedData)
      # puts @selectedData
      # puts @programs.inspect
      render json: @programs
    #   log(request.body.read)
 end
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })
    # @customer = ShopifyAPI::Customer.find(:all, params: { limit: 10 })
    # puts @orders.inspect
    @shop = Shop.all
      # @tiers = Tiers.all
      # i=0;
      # @userlist = @tiers.map do |u|
      #   { :_id =>i=i+1 ,:name => u.tier }
      # end
      # json = @userlist.to_json
      # puts json
      # for i in 0..@tiers.length-1
      #   puts @tiers[i]['tier']
      # end
  end
end
