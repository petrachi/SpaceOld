#!/bin/env ruby
# encoding: utf-8

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #1",
  :summary => "On va parler des opérateur \"et\" et \"ou\"",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/bshV5tqzIwE?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %Q{
    <p>
      Alors voilà jean-michel, un super screencast dites donc !
    </p>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_1

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #2",
  :summary => "On va parler des blocks",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/8Slu1_5xUYA?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %Q{
    <p>
      Alors voilà jean-michel, un super screencast dites donc !
    </p>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_2
    
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #3",
  :summary => "On va parler de refactoring",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/s6iMBtzo3nE?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %Q{
    <p>
      Alors voilà jean-michel, un super screencast dites donc !
    </p>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_3
      
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #4",
  :summary => "On va parler des null objects",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/Z74ANuUEs7g?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %Q{
    <p>
      Alors voilà jean-michel, un super screencast dites donc !
    </p>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_4
        
Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #5",
  :summary => "On va parler de method missing",
  :embed => "<iframe width=\"840\" height=\"500\" src=\"//www.youtube.com/embed/X1bmSh72JoA?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %Q{
    <p>
      Alors voilà jean-michel, un super screencast dites donc !
    </p>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_5
