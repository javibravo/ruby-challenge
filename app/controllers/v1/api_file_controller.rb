module V1
  class ApiFileController < ApplicationController

    def upload
      if params[:file].size > RubyChallenge::Application.config.file_max_size
        render :status => :request_header_fields_too_large, :text => "File size exceeded, max 10MB"
      else
        text_file = TextFile.new
        text_file.name = SecureRandom.uuid()
        text_file.original_name = params[:file].original_filename

        uploaded_file = save_uploaded_file(params[:file], text_file.getPath)
        word_counter = WordsCounterService.new(uploaded_file)
        word_counter.parse

        text_file.total_words = word_counter.total
        text_file.distinct_words = word_counter.distinct
        text_file.words = word_counter.words.to_json
        text_file.save

        render json: create_response(text_file)
      end
    end

    def get
      text_file = TextFile.find_by name: params['name']
      response = {}
      if text_file
        response = create_response(text_file)
      end
      render json: response
    end

    private

    def save_uploaded_file(uploaded_file, path)
      saved_file = File.open(path, 'w+')
      saved_file.write(uploaded_file.read)
      saved_file.rewind
      saved_file
    end

    def create_response(text_file)
      {
          'name' => text_file.name,
          'total' => text_file.total_words,
          'distinct' => text_file.distinct_words,
          'words' => JSON.parse(text_file.words)
      }
    end
  end
end

