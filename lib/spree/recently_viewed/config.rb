module Spree
  module RecentlyViewed
    # Singleton class to access the shipping configuration object (RecentlyViewedConfiguration.first by default) and it's preferences.
    #
    # Usage:
    #   Spree::RecentlyViewed::Config[:foo]                  # Returns the foo preference
    #   Spree::RecentlyViewed::Config[]                      # Returns a Hash with all the tax preferences
    #   Spree::RecentlyViewed::Config.instance               # Returns the configuration object (RecentlyViewedConfiguration.first)
    #   Spree::RecentlyViewed::Config.set(preferences_hash)  # Set the active shipping preferences as especified in +preference_hash+
    class Config
      include Singleton
      include PreferenceAccess

      class << self
        def instance
          return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
          RecentlyViewedConfiguration.find_or_create_by_name("Default recently_viewed configuration")
        end
      end
    end
  end
end