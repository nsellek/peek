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
<<<<<<< HEAD

				@picture.house_id = house.id
				@picture.save
=======
				@picture.house_id = house.id
				@picture.save
				person = @picture.user.first_name + " " + @picture.user.last_name
				house_name = @picture.house.name
				url = @picture.image.url
				Picture.enroll(url, person, house_name)
>>>>>>> 7eef255614a339e4d73edd8d9c60f426e9da9e70
			end
			p 'picture saved'
			redirect_to root_path
		else
			p 'picture didnt save'
		end
	end

<<<<<<< HEAD
	def enroll
    url = @picture.image.url
    Picture.enroll(url)
    render root_path, notice: 'Face enfolled'
  end

  def recognize
    url = @picture.image.url
    successtest = Picture.recognize(url)
    if successtest == "success"
      render :great_success
    else
      render :great_fail
    end
  end
=======
	def matchPage
		@picture = Picture.new
	end

	def match
		user = User.find(params[:user_id])
		house = House.find(params[:house_id])
		if params[:picture][:image][0]
			@picture = user.pictures.build(image: params[:picture][:image][0])
			@picture.house_id = house.id
			@picture.save
			url = @picture.image.url
			house_name = @picture.house.name
			number = current_user.phone_number
			Picture.recognize(url, house_name, number)
    	redirect_to root_path
    end
	end
>>>>>>> 7eef255614a339e4d73edd8d9c60f426e9da9e70

  private

  def pic_params
  	params.require(:picture).permit(:image)
  end
end
