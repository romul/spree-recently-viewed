# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RecentlyViewedExtension < Spree::Extension
  version "1.0"
  description "Adds recently viewed products to Spree"
  url "http://github.com/romul/spree-recently-viewed"
  
  def activate
    Spree::Config.set(:recently_viewed_products_max_count => 5) if Spree::Config.instance
    
    Spree::BaseHelper.class_eval do
      def get_recently_viewed_products_ids
        if session['recently_viewed_products'].nil? 
          []
        else   
          session['recently_viewed_products'].split(', ')
        end
      end
    end
    
    Product.class_eval do
      def self.find_by_array_of_ids(ids)
        ids.map! { |id| id.to_i }
        products = Product.find(:all, :conditions => ["id IN (?)", ids])
        sorted_products = Array.new(ids.size)
        products.each do |p|
          idx = ids.index(p.id)
          sorted_products[idx] = p unless idx.nil?
        end
        sorted_products.delete(nil)
        sorted_products     
      end
    end
  end
end
