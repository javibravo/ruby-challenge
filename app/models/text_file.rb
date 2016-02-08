class TextFile < ActiveRecord::Base
  def getPath
    File.join(Rails.root, RubyChallenge::Application.config.file_store_path, self.name)
  end
end
