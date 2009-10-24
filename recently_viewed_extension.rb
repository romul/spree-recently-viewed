# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RecentlyViewedExtension < Spree::Extension
  version "1.0"
  description "Adds recently viewed products to Spree"
  url "http://github.com/romul/spree-recently-viewed"
  
  def activate
    Spree::Config.set(:recently_viewed_products_max_count => 5) if Spree::Config.instance
  end
end
