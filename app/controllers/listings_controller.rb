class ListingsController < ApplicationController
	before_action :require_host, only: [:new, :create]
	before_action :require_owner, only: [:edit, :update, :destroy]
	before_action :require_moderator, only: :verify
	before_action :set_listing, only: [:edit, :update, :destroy, :verify]

	def index
		@listings = Listing.where(verified: true)
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.new(listing_params)
		@listing.save
		redirect_to listing_path(@listing) #listing/:id
	end

	def show
		# @listing = Listing.find(params[:id])
	end

	def edit
		# @listing = Listing.find(params[:id])
	end

	def update
		# @listing = Listing.find(params[:id])
		@listing.update(listing_params)
		redirect_to listing_path(@listing)
	end

	def destroy
		# @listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

	def verify
		# @listing = Listing.find(params[:id])
		@listing.update(verified: true)
		redirect_to admin_listings_path
	end

	private
	def listing_params
		params.require(:listing).permit(:location,:tags,:name,:place_type, :property_type, :room_number, :bed_number, :guest_number,:country,:state, :city, :zipcode, :price, :description)
	end

	def require_host
		unless current_user.host? || current_user.admin?
			redirect_to listings_path
		end
	end

	def require_owner
		set_listing
		unless current_user == listing.user || current_user.admin?
			redirect_to listings_path
		end
	end

	def require_moderator
		unless current_user.moderator? || current_user.admin?
			redirect_to listings_path
		end
	end

	def set_listing
		@listing = Listing.find(params[:id])
	end
end


