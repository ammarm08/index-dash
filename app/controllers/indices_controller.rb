class IndicesController < ApplicationController

	# root page. shows names of all indices
	def index
		@indices = Index.populate
	end

	# renders specific index's view page (shows all brands in index and their 30-day stats)
	def show
		@engagements = Index.get_engagement(params[:id])
	end

end
