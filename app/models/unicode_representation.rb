class UnicodeRepresentation < Representation
  validates_presence_of :codepoint
  validates_format_of :codepoint, :with => /^([0-9a-fA-F]{4,5}|10[0-9a-fA-F]{4})$/
  validates_uniqueness_of :codepoint
end