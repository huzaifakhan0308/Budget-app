class GroupsController < ApplicationController
  def index
    @categories = Group.all
  end
end
