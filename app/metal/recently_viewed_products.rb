# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)
   
class RecentlyViewedProducts
  def self.call(env)  
    if env["PATH_INFO"] =~ /^\/recently\/viewed\/products/
      request = Rack::Request.new(env)
      params = request.params
      id = params['product_id']
      session = env['rack.session']
      rvp = session['recently_viewed_products']
      rvp = rvp.nil? ? [] : rvp.split(', ')
      rvp.delete(id)
      rvp << id
      rvp.delete_at(0) if rvp.size > 10
      env['rack.session']['recently_viewed_products'] = rvp.join(', ')
      [200, {"Content-Type" => "text/html"}, ["/*\n#{rvp.inspect}\n#{session.inspect}\n*/"]]  
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
