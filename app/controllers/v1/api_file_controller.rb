module V1
  class ApiFileController < ApplicationController

    def create
      if params[:file].size > RubyChallenge::Application.config.file_max_size
        render :status => :request_header_fields_too_large, :text => "File size exceeded, max 10MB"
      else
        file_name = SecureRandom.uuid()
        path = File.join(Rails.root, RubyChallenge::Application.config.file_store_path, file_name)

        uploaded_file = File.open(path, "w+")
        uploaded_file.write(params[:file].read)
        uploaded_file.rewind

        word_counter = WordsCounter.new(uploaded_file)
        word_counter.parse

        response = {
            'name' => file_name,
            'total' => word_counter.total,
            'distinct' => word_counter.distinct,
            'words' => word_counter.words
        }
        render json: response
      end
    end

  end
end

