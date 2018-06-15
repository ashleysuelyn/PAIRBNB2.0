class AdminsController < ApplicationController
	before_action :require_moderator

	def unverified_listings
		@listings = Listing.where(verified: false)
		render "listings_index" # without this line it would have gone to unverified_listings.html.erb
	end

	private
	def require_moderator
		unless current_user.moderator? || current_user.admin?
			redirect_to listings_path
		end
	end
end
