# Allow the metal piece to run in isolation  
require(SPREE_ROOT + "/config/environment") unless defined?(Rails)  
   
class RecentlyViewedProducts < Rails::Rack::Metal  
  def self.call(env)  
    if env["PATH_INFO"] =~ /^\/recently\/viewed\/products/
      request = Rack::Request.new(env)
      params = request.params
      id = params['id'].to_i
      session = env['rack.session']
      rvp = session['recently_viewed_products']
      rvp ||= []
      rvp.delete(id)
      rvp << id      
      rvp.delete_at(0) if rvp.size > 10
      session['recently_viewed_products'] = rvp
      [200, {"Content-Type" => "text/html"}, ["//Product ##{id} added to recently viewed"]]  
    else  
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]  
    end  
  end  
end  
