namespace :db do
  desc "Bootstrap your database for Spree."
  task :bootstrap  => :environment do
    # load initial database fixtures (in db/sample/*.yml) into the current environment's database
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
    Dir.glob(File.join(RecentlyViewedExtension.root, "db", 'sample', '*.{yml,csv}')).each do |fixture_file|
      Fixtures.create_fixtures("#{RecentlyViewedExtension.root}/db/sample", File.basename(fixture_file, '.*'))
    end
  end
end

namespace :spree do
  namespace :extensions do
    namespace :recently_viewed do
      desc "Copies public assets and metal stuff of the Recently Viewed to the instance directories."
      task :update => :environment do
        is_svn_git_or_dir = proc {|path| path =~ /\.svn/ || path =~ /\.git/ || File.directory?(path) }
        
        {"/public/**/*" => RAILS_ROOT, "/app/metal/*" => SPREE_ROOT}.each do |mask, target_root|
          Dir[RecentlyViewedExtension.root + mask].reject(&is_svn_git_or_dir).each do |file|
            path = file.sub(RecentlyViewedExtension.root, '')
            directory = File.dirname(path)
            puts "Copying #{path}..."
            mkdir_p target_root + directory
            cp file, target_root + path
          end
        end
      end  
    end
  end
end
