require 'rubygems'
require 'openssl'
require 'rack/utils'
require 'shopify_app'
class VerifyhmacverificationController < ActionController::Base
      SHARED_SECRET = ShopifyApp.configuration.secret
     # SHARED_SECRET = 'c3d91fda446c565877bf988a154'
  def check(request,params)
      puts 'verifyhmacverification called...'
      @signature = params[:signature]
      query_hash = Rack::Utils.parse_query(request.query_string)
      signature = query_hash.delete("signature")
      sorted_params = query_hash.collect{ |k, v| "#{k}=#{Array(v).join(',')}" }.sort.join
      #sorted_params:  id=5781374414path_prefix=/apps/starter-appshop=teststoredev2.myshopify.comtimestamp=1489991696
      calculated_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), VerifyhmacverificationController::SHARED_SECRET, sorted_params)
       if @signature != calculated_signature 
            puts 'Verification failed...'
            return false
       else
            puts 'Verification success...'
            return true
       end
    #   raise 'Invalid signature' if @signature != calculated_signature
  end
end