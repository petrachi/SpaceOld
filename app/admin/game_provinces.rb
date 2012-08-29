ActiveAdmin.register Game::Province do
  menu :parent => "Space Game"
  
  form :namespace=>"game" do |f|
    f.inputs *Game::Province.column_names
    f.buttons
  end
  
end
