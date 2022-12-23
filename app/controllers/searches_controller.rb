class SearchesController < ApplicationController
	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		unless @content.present?#contentの中が入っているかを確認する
			if request.referer.present?
				redirect_to request.referer, notice: "検索ワードを入力してください"#入っていなければ元のページに戻る
			end
		end
		if @model == 'user'
			@records = User.search_for(@content, @method).page(params[:page]).per(15)
		else
			@records = Info.search_for(@content, @method).page(params[:page]).per(15)
		end
	end
end
