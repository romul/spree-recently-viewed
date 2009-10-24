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
      rvp_max_count = Spree::Config[:recently_viewed_products_max_count] || 5
      rvp.delete_at(0) if rvp.size > rvp_max_count.to_i
      session['recently_viewed_products'] = rvp.join(', ')
      headers = {
        "Content-Type" => "text/css",
        "Cache-Control" => "no-cache, no-store, max-age=0, must-revalidate",
        "Pragma" => "no-cache",
        "Expires" => "Fri, 23 Oct 2009 00:00:00 GMT"
      }
      [200, headers, ["/*#{session['recently_viewed_products']}*/"]]  
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
