class BrandsController < ApplicationController

	# show page for each individual brand's 30-day stats
	def show
		@engagements = Index.daily_engagement(params[:index_id], params[:id])
	end
end
