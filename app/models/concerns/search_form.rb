class SearchForm
  include ActiveModel::Model

  attr_accessor :q
end

# == Example ==

# - Model -

# class Ingredient < ActiveRecord::Base
#
#   scope :sorted, ->{ order(name: :asc) }
#   scope :named, ->(q) { where("name ilike ?", "%#{q}%") }

# - View -

# .filter_wrapper{ style: "margin-bottom: 20px;" }
#   = form_for @search, url: ingredients_path, html: {method: :get}, class: "form-horizontal" do |f|
#     .form-group
#       .input-group
#         = f.search_field :q, class: "form-control"
#         %span.input-group-btn
#           = f.button fa_icon("search"), class: "btn btn-default"

# - Controller -

# class IngredientsController < ApplicationController
#
#   before_action :search_ingredients, only: :index
#
#   def index
#   end
#
# def search_ingredients
#   @search = SearchForm.new(params[:search_form])
#   @ingredients = if @search.q.present?
#     then Ingredient.all.named(@search.q)
#     else Ingredient.all
#   end.sorted
# end
