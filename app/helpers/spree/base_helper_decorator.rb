Spree::BaseHelper.class_eval do
  def get_recently_viewed_products_ids
    if session['recently_viewed_products'].nil?
      []
    else
      session['recently_viewed_products'].split(', ')
    end
  end
  def get_recently_viewed_products
    Product.find_by_array_of_ids(get_recently_viewed_products_ids)
  end
end