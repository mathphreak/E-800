module EnsureUniversalNewlines
  def self.fix(x)
    if x.is_a?(String)
      x.encode(universal_newline: true)
    else
      x
    end
  end
end
