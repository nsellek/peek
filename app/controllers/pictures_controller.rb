class PicturesController < ApplicationController

	def upload
		@picture = Picture.new

	end

	def create
		user = User.find(params[:user_id])
		house = House.find(params[:house_id])

		if params[:picture][:image]
			params[:picture][:image].each do |image|
				@picture = user.pictures.build(image: image)

				@picture.house_id = house.id
				@picture.save

				person = @picture.user.first_name + " " + @picture.user.last_name
				house_name = @picture.house.name
				url = @picture.image.url
				Picture.enroll(url, person, house_name)
			end
			p 'picture saved'
			redirect_to root_path
		else
			p 'picture didnt save'
		end
	end

  def recognize
    url = @picture.image.url
    successtest = Picture.recognize(url)
    if successtest == "success"
      redirect_to root_path
    else
      render :great_fail
    end
  end

  private

  def pic_params
  	params.require(:picture).permit(:image)
  end
end
