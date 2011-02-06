class LatexRepresentation < Representation
  validates_presence_of :command # package is optional
  validates_uniqueness_of :command, scope: :package
  has_one :attachment, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachment
  validates_presence_of :attachment
  
  def image
    attachment.data_uri
  end
  
end