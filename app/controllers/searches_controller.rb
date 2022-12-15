class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method).page(params[:page])
		else
			@records = Info.search_for(@content, @method).page(params[:page])
		end
	end
end
