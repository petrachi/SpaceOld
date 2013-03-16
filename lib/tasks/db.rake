namespace :db do
  desc "run db:drop, db:create, db:migrate and db:seed tasks in a row."
  task :rebuild => :environment do
    if Rails.env == "production"
      system "heroku pg:reset DATABASE_URL --confirm afternoon-plateau-3851"
      system "heroku run rake db:migrate"
      system "heroku run rake db:seed"
    else
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke
      Rake::Task["db:seed"].invoke
    end
  end
end
