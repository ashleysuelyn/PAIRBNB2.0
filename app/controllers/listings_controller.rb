class ListingsController < ApplicationController
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
		@listing = Listing.find(params[:id])
	end

	private
	def listing_params
		params.require(:listing).permit(:location,:tags,:name,:place_type, :property_type, :room_number, :bed_number, :guest_number,:country,:state, :city, :zipcode, :price, :description)
	end
end


