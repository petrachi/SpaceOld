#!/bin/env ruby
# encoding: utf-8

Blog::Screencast.create :user => @primal_user.blog_user,
  :title => "Try Hard #1",
  :summary => "On va parler des opérateur \"et\" et \"ou\"",
  :embed => "<iframe width=\"960\" height=\"720\" src=\"//www.youtube.com/embed/bshV5tqzIwE?rel=0\" frameborder=\"0\" allowfullscreen></iframe>",
  :snippet => Blog::Snippet.create(:erb => %Q{
    <p>
      Alors voilà jean-michel, un super screencast dites donc !
    </p>
  },
  :published => true),
  :pool => :try_hard,
  :published => true,
  :tag => :try_hard_1

