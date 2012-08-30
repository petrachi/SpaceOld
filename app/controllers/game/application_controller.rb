class Game::ApplicationController < ApplicationController
  include Game; layout "game/application"
  
  include Game::ApplicationHelper
end
