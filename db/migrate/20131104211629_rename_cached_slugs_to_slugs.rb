class RenameCachedSlugsToSlugs < ActiveRecord::Migration
  def up
    rename_column(:syms, :cached_slug, :slug)
    rename_column(:users, :cached_slug, :slug)
  end

  def down
    rename_column(:syms, :slug, :cached_slug)
    rename_column(:users, :slug, :cached_slug)
  end
end
