require 'rails_helper'
# require 'FileUtils'

RSpec.describe V1::ApiFileController do

  before :each do
    @file = fixture_file_upload('file_example_ok.txt', 'text')
  end

  describe "POST #create" do
    it "is success" do
      expected_response_body = getExpectedResponse

      post :create, :file => @file
      response_body = JSON.parse response.body
      file_path = File.join(Rails.root, RubyChallenge::Application.config.file_store_path, response_body['name']);
      expect(response).to have_http_status 200
      expect(response_body['total']).to eq expected_response_body['total']
      expect(response_body['distinct']).to eq expected_response_body['distinct']
      expect(response_body['words']).to eq expected_response_body['words']
      expect(File).to exist file_path

      FileUtils.rm(file_path)
    end

    it "File size exceeded" do
      RubyChallenge::Application.config.file_max_size = 1.bytes
      post :create, :file => @file
      expect(response).to have_http_status 431
    end
  end

  private
  def getExpectedResponse
    return {
        "total" => 37,
        "distinct" => 25,
        "words" => {
            "This" => 1,
            "is" => 1,
            "a" => 2,
            "test" => 2,
            "file" => 3,
            "to" => 2,
            "the" => 5,
            "new" => 1,
            "API" => 1,
            "service" => 1,
            "upload" => 1,
            "files" => 1,
            "It" => 1,
            "will" => 1,
            "count" => 1,
            "number" => 2,
            "of" => 2,
            "words" => 1,
            "in" => 2,
            "and" => 1,
            "fo" => 1,
            "times" => 1,
            "each" => 1,
            "them" => 1,
            "appear" => 1
        }
    }
  end

end