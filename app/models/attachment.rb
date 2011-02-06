class Attachment < ActiveRecord::Base
  extend ActionView::Helpers::NumberHelper
  belongs_to :attachable, polymorphic: true
  # attr_accessible :uploaded_file
  
  validates_presence_of :data
  validates_each :uploaded_file do |record, attr, val|
    record.errors[:uploaded_file] << "Only png images." unless val.content_type == 'image/png'
    size = 32.kilobytes
    record.errors[:uploaded_file] << "Must be smaller than #{number_to_human_size(size)}" unless val.size < size
  end
  
  def data_uri
    "data:#{content_type};base64,#{ActiveSupport::Base64.encode64(data)}"
  end
  
  def uploaded_file=(uploaded_file)
    @uploaded_file = uploaded_file.tap do |f|
      self.data = f.read
      self.content_type = f.content_type
    end
  end
  
  def uploaded_file
    @uploaded_file
  end
  
end
