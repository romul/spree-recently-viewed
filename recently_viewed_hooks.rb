class RecentlyViewedHooks < Spree::ThemeSupport::HookListener
  
  insert_after :inside_head do
    '
    <% if @product %>
      <%= stylesheet_link_tag("/recently/viewed/products.css?product_id=#{@product.id}") %>
    <% end %>
    '
  end
    
end
