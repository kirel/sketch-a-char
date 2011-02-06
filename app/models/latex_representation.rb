class LatexRepresentation < Representation
  validates_presence_of :command # package is optional
  validates_uniqueness_of :command, scope: :package  
end