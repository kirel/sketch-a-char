class MigrateAttachmentsToDragonfly < ActiveRecord::Migration
  def up
    add_column :attachments, :image_uid, :string

    Attachment.reset_column_information
    Attachment.find_each do |a|
      a.image = a.data
      a.save!
    end

    remove_column :attachments, :data, :content_type
  end

  def down
    add_column :attachments, :data, :binary
    add_column :attachments, :content_type, :string

    Attachment.reset_column_information
    Attachment.find_each do |a|
      a.data = a.image.data
      a.content_type = a.image.mime_type
      a.save!
    end

    remove_column :attachments, :image_uid
  end
end

