  SimpleApp.controllers :admin do
    get :show, :with => :id do
      # url is generated as "/admin/show/#{params[:id]}"
      # url_for(:admin, :show, :id => 5) => "/admin/show/5"
    end

    get :other, :with => [:id, :name] do
      # url is generated as "/admin/other/#{params[:id]}/#{params[:name]}"
      # url_for(:admin, :other, :id => 5, :name => "hey") => "/admin/other/5/hey"
    end
  end
