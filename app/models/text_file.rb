class TextFile < ActiveRecord::Base

  validates :name, uniqueness: true

  def getPath
    File.join(Rails.root, RubyChallenge::Application.config.file_store_path, self.name)
  end
end
