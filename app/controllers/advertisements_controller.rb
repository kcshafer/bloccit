class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = Advertisement.new
    @advertisement.title = params[:advertisement][:title]
    @advertisement.copy = params[:advertisement][:copy]
    @advertisement.price = params[:advertisement][:price]

    if @advertisement.save
        flash[:notice] = "Advertisement was saved"
        redirect_to @advertisement
    else
        flash.now[:alert] = "There was an error, please try again"
        render :new
    end
  end

  def edit
  end
end
