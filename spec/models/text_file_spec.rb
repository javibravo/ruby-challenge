require 'rails_helper'

RSpec.describe TextFile, type: :model do

  before :each do
    @file_name = 'test-file-name'
    @text_file = TextFile.new(
        :name => @file_name,
        :original_name => 'original-file-name'
    )
  end

  context 'Validate fields' do
    it 'should include the :name attribute' do
      expect(@text_file.attributes).to include('name')
    end
    it 'should include the :original_name attribute' do
      expect(@text_file.attributes).to include('original_name')
    end
    it 'should include the :total_words attribute' do
      expect(@text_file.attributes).to include('total_words')
    end
    it 'should include the :distinct_words attribute' do
      expect(@text_file.attributes).to include('distinct_words')
    end
    it 'should include the :words attribute' do
      expect(@text_file.attributes).to include('words')
    end
  end

  context 'Validate Path' do
    it 'It should create real path' do
      expected_path = File.join(Rails.root, RubyChallenge::Application.config.file_store_path, @file_name)
      expect(@text_file.getPath).to eq(expected_path)
    end
  end

end
