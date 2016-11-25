class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_image, except: [:create]
  before_action :set_parent
  before_action :uuid_permission_check!

  def create
    folder = params[:parent_type].pluralize
    Image.create!(parent_uuid: @parent.uuid,
                  user: current_user,
                  file_key: "#{folder}/#{@parent.uuid}-image-#{params[:filename]}",
                  file_last_modified: Time.parse(params[:lastModifiedDate]))

    render nothing: true
  end


  def update
    @image.update(cover: params[:cover])
    render nothing: true
  end

  def destroy
    @image.destroy
    render nothing: true
  end


  private

  def set_parent
    return @image.parent if @image

    parent_types = ["game", "arcade_machine"]
    raise ArgumentError, "Invalid parent_type: #{params[:parent_type]}" if !parent_types.include?(params[:parent_type])

    klass = params[:parent_type].camelize.constantize
    @parent = klass.find_by(uuid: params[:uuid]) || klass.new(uuid: params[:uuid])
  end

  def uuid_permission_check!
    @parent.new_record? || require_admin_or_ownership!(@parent)
  end

end