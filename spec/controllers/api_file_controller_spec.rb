require 'rails_helper'
# require 'FileUtils'

RSpec.describe V1::ApiFileController do

  describe 'POST #upload' do
    it 'is success' do
      file = fixture_file_upload('file_example_ok.txt', 'text')
      post :upload, :file => file

      response_body = JSON.parse response.body
      file_path = File.join(Rails.root, RubyChallenge::Application.config.file_store_path, response_body['name'])
      validate_response(response, response_body, get_expected_response, file_path)

      FileUtils.rm(file_path)
    end

    it 'is success with words with #blue' do
      file = fixture_file_upload('file_example_with_blue.txt', 'text')
      post :upload, :file => file

      response_body = JSON.parse response.body
      file_path = File.join(Rails.root, RubyChallenge::Application.config.file_store_path, response_body['name'])
      validate_response(response, response_body, get_expected_response,file_path)

      FileUtils.rm(file_path)
    end

    it 'File size exceeded' do
      file = fixture_file_upload('file_example_ok.txt', 'text')
      RubyChallenge::Application.config.file_max_size = 1.bytes
      post :upload, :file => file
      expect(response).to have_http_status 431
    end
  end

  describe 'GET #get' do
    it 'is success' do
      file_name = 'test-file-name'
      original_file_name = 'test-original-file-name'
      total_words = 10
      distinct_words = 5
      words = {'first' => 1, 'test' => 1, 'to' => 1, 'count' => 1, 'wordstest' => 1}
      text_file = TextFile.new(
          :name => file_name,
          :original_name => original_file_name,
          :total_words => total_words,
          :distinct_words => distinct_words,
          :words => words.to_json
      )
      text_file.save

      get :get, :name => file_name
      response_body = JSON.parse response.body
      expect(response).to have_http_status 200
      expect(response_body['name']).to eq file_name
      expect(response_body['total']).to eq total_words
      expect(response_body['distinct']).to eq distinct_words
      expect(response_body['words']).to eq words
    end

    it 'file name does not exists' do
      get :get, :name => 'test-file-name'
      response_body = JSON.parse response.body
      expect(response).to have_http_status 200
      expect(response_body).to be_empty
    end
  end

  private

  def validate_response (response, response_body, expected_response_body, file_path)
    expect(response).to have_http_status 200
    expect(response_body['total']).to eq expected_response_body['total']
    expect(response_body['distinct']).to eq expected_response_body['distinct']
    expect(response_body['words']).to eq expected_response_body['words']
    expect(response_body['name']).to_not eq ''
    expect(File).to exist file_path
  end

  def get_expected_response
    return {
        'total' => 37,
        'distinct' => 25,
        'words' => {
            'this' => 1,
            'is' => 1,
            'a' => 2,
            'test' => 2,
            'file' => 3,
            'to' => 2,
            'the' => 5,
            'new' => 1,
            'api' => 1,
            'service' => 1,
            'upload' => 1,
            'files' => 1,
            'it' => 1,
            'will' => 1,
            'count' => 1,
            'number' => 2,
            'of' => 2,
            'words' => 1,
            'in' => 2,
            'and' => 1,
            'fo' => 1,
            'times' => 1,
            'each' => 1,
            'them' => 1,
            'appear' => 1
        }
    }
  end

end