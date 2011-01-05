Product.class_eval do
  def self.find_by_array_of_ids(ids)
    products = Product.find(:all, :conditions => ["id IN (?)", ids])
    ids.map{|id| products.detect{|p| p.id == id.to_i}}.compact
  end
end