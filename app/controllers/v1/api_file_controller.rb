module V1
  class ApiFileController < ApplicationController

    def create
      if params[:file].size > RubyChallenge::Application.config.file_max_size
        render :status => :request_header_fields_too_large, :text => "File size exceeded, max 10MB"
      else
        text_file = TextFile.new
        text_file.name = SecureRandom.uuid()
        text_file.original_name = params[:file].original_filename

        path = File.join(Rails.root, RubyChallenge::Application.config.file_store_path, text_file.name)
        uploaded_file = File.open(path, "w+")
        uploaded_file.write(params[:file].read)
        uploaded_file.rewind

        word_counter = WordsCounter.new(uploaded_file)
        word_counter.parse

        text_file.total_words = word_counter.total
        text_file.distinct_words = word_counter.distinct
        text_file.words = word_counter.words.to_json
        text_file.save

        response = {
            'name' => text_file.name,
            'total' => word_counter.total,
            'distinct' => word_counter.distinct,
            'words' => word_counter.words
        }
        render json: response
      end
    end

  end
end

