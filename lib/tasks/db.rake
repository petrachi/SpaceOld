namespace :db do
  desc "run db:drop, db:create, db:migrate and db:seed tasks in a row."
  task :rebuild => :environment do
    if Rails.env == "production"
      system "heroku pg:reset DATABASE_URL --confirm afternoon-plateau-3851"
      system "heroku run rake db:migrate"
      system "heroku run rake db:seed"
    else
      system "rake db:drop"
      system "rake db:create"
      system "rake db:migrate"
      system "rake db:seed"
    end
  end
end
