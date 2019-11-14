class PhotosController < ApplicationController
  def index
    @photos = Photo.all.order({ :owner_id => :asc })

    #render({ :json => photos.as_json })
    render({ :template => "users/photo.html.erb"})
  end

  def show
    the_id = params.fetch(:the_photo_id)
    @photo = Photo.where({ :id => the_id }).at(0)

    #render({ :json => photo.as_json })
    render({ :template => "users/photos_id.html.erb"})
  end

  def create
    photo = Photo.new

    photo.owner_id = params.fetch(:input_owner_id, nil)
    photo.caption = params.fetch(:input_caption, nil)
    photo.image = params.fetch(:input_image, nil)
    photo.likes_count = params.fetch(:input_likes_count, 0)
    photo.comments_count = params.fetch(:input_comments_count, 0)
    
    photo.save

    #render({ :json => photo.as_json })
    redirect_to("/photos/#{photo.id}")
  end

  def update
    the_id = params.fetch(:the_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)


    photo.owner_id = params.fetch(:input_owner_id, photo.owner_id)
    photo.caption = params.fetch(:input_caption, photo.caption)
    photo.image = params.fetch(:input_image, photo.image)
    photo.likes_count = params.fetch(:input_likes_count, photo.likes_count)
    photo.comments_count = params.fetch(:input_comments_count, photo.comments_count)
    
    photo.save

    #render({ :json => photo.as_json })
    redirect_to("/photos/#{photo.id}")
  end

  def destroy
    the_id = params.fetch(:the_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)

    photo.destroy

    #render({ :json => photo.as_json })
    redirect_to("/photos")
  end
 
  def comments
    the_id = params.fetch(:the_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)

    render({ :json => photo.comments.as_json })
  end

  def likes
    the_id = params.fetch(:the_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)

    render({ :json => photo.likes.as_json })
  end

  def fans
    the_id = params.fetch(:the_photo_id)
    photo = Photo.where({ :id => the_id }).at(0)

    render({ :json => photo.fans.as_json })
  end
end
