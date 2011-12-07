class UnicodeRepresentation < Representation
  validates_presence_of :codepoint
  validates_numericality_of :codepoint
  validates_uniqueness_of :codepoint
  validates_format_of :unicode_or_codepoint, with: /^(.|[uU]\+([0-9a-fA-F]{4,5}|10[0-9a-fA-F]{4}))$/

  def unicode_or_codepoint=(string)
    self[:codepoint] = case string
      when /^[uU]\+([0-9a-fA-F]{4,5}|10[0-9a-fA-F]{4})$/
        $1.to_i(16)
      else
        string.unpack("U").first
      end
  end

  def unicode_or_codepoint
    unicode or hex_codepoint
  end

  def hex_codepoint
    "U+" + ("%04X" % codepoint) if codepoint
  end

  def to_s
    [codepoint].pack("U") if codepoint
  end

  def to_i
    codepoint
  end

  def unicode
    to_s
  end

  def unicode=(s)
    self.codepoint = s.unpack("U").first
  end

end
