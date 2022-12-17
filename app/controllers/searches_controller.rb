class SearchesController < ApplicationController

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method).page(params[:page]).per(15)
		else
			@records = Info.search_for(@content, @method).page(params[:page]).per(15)
		end
	end
end
