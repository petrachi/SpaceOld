#!/bin/env ruby
# encoding: utf-8

Blog::Version.create :experiment => @sphere_svg_experiment,
  :title => "1.0",
  :code => %q{
    Une sphère tout en web :). Pas de flash, pas de librairies javascript, juste des <i>div</i> et des <i>transforms</i>. 
  },
  :published => true
