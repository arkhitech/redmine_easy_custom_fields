# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :easy_custom_fields do
  collection do
    post :index
  end
  

end

resources :custom_fields do
  collection do
    post :rearrange_fields
  end
end
