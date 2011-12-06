class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  image_accessor :image
  validates_presence_of :image
  validates_property :format, :of => :image, :in => [:jpeg, :png, :gif]

  def data_uri
    Rails.cache.fetch("data_uri_#{id}_#{updated_at}") { "data:image/jpeg;base64,#{ActiveSupport::Base64.encode64(image.thumb('100x100').encode(:jpg).data)}" }
  end

end
