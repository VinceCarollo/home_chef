class ChefsController < ApplicationController
  def new
    @chef = Chef.new
  end
end