class SearchForm
  include ActiveModel::Model

  attr_accessor :q
end

### Example ###

# ==> Model

# class User < ActiveRecord::Base
#   scope :sorted, ->{ order(username: :asc) }
#   scope :search, ->(q) { where("username ilike ?", "%#{q}%") }
# end

# ==> View

# .filter_wrapper{ style: "margin-bottom: 20px;" }
#   = form_for @search, url: ingredients_path, html: {method: :get}, class: "form-horizontal" do |f|
#     .form-group
#       .input-group
#         = f.search_field :q, class: "form-control"
#         %span.input-group-btn
#           = f.button fa_icon("search"), class: "btn btn-default"

# ==> Controller

# class UsersController < ApplicationController
#
#   before_action :ensure_admin!,     except: :show
#   before_action :authenticate_user! # all actions
#   before_action :search_users,      only: :index
#
#   def index
#   end
#
#   private
#
#     def search_users
#       @search = SearchForm.new(params[:search_form])
#       @users =  if @search.q.present?
#         then User.search(@search.q)
#         else User.all
#         end.sorted.paginate(page: params[:page])
#     end
# end
