class HomeController < ApplicationController

  def index
    render json: { test: "hello ! " }
  end

end
