# TODO precache this somehow - react to changes with AR Observers
module AppData
  def self.to_json options = {}
    Sym.all.to_json :except => [:cached_slug, :created_at, :updated_at],
      :methods => :sam,
      :include => {
        unicode_representations: { only: :codepoint, methods: :unicode },
        latex_representations: { only: [:command, :package], methods: :image },
        representations: {}
      }
  end
end