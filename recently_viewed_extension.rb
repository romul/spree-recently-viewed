# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RecentlyViewedExtension < Spree::Extension
  version "1.0"
  description "Adds recently viewed products to Spree"
  url "http://github.com/romul/spree-recently-viewed"
  
  def activate 
    Rails::Rack::Metal.metal_paths += [File.dirname(__FILE__) + "/app/metal"]
  end
end
