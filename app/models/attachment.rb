class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  image_accessor :image
  validates_presence_of :image
  validates_property :format, :of => :image, :in => [:jpeg, :png, :gif]

  def data_uri
    "data:#{image.mime_type};base64,#{ActiveSupport::Base64.encode64(image.data)}"
  end

end
