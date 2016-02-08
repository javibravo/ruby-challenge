require 'rails_helper'

RSpec.describe WordsCounterService, '#Basic' do

  context 'Most simple text' do
    it 'counts each occurence of words' do
      source = double('source', :read => 'First test to count words test')
      words_counter = WordsCounterService.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 6
      expect(words_counter.distinct).to eq 5
      expect(words_counter.words).to include ({'first' => 1, 'test' => 2, 'to' => 1, 'count' => 1, 'words' => 1})
    end
  end

  context 'With multiple white spaces ' do
    it 'counts each occurence of words' do
      source = double(
          'source',
          :read => 'First    test to  count     words
                    test'
      )
      words_counter = WordsCounterService.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 6
      expect(words_counter.distinct).to eq 5
      expect(words_counter.words).to include ({'first' => 1, 'test' => 2, 'to' => 1, 'count' => 1, 'words' => 1})
    end
  end

  context 'With punctuation marks' do
    it 'counts each occurence of words' do
      source = double('source', :read => 'First test, to count. words test. re-play')
      words_counter = WordsCounterService.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 7
      expect(words_counter.distinct).to eq 6
      expect(words_counter.words).to include ({'first' => 1, 'test' => 2, 'to' => 1, 'count' => 1, 'words' => 1, 'replay' => 1})
    end
  end

  context 'With more punctuation marks' do
    it 'counts each occurence of words' do
      source = double('source', :read => 'First test, to count. words?test')
      words_counter = WordsCounterService.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 5
      expect(words_counter.distinct).to eq 5
      expect(words_counter.words).to include ({'first' => 1, 'test' => 1, 'to' => 1, 'count' => 1, 'wordstest' => 1})
    end
  end

  context 'With isolated punctuation marks' do
    it 'counts each occurence of words' do
      source = double('source', :read => 'First test, ** to count. ( words?test')
      words_counter = WordsCounterService.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 5
      expect(words_counter.distinct).to eq 5
      expect(words_counter.words).to include ({'first' => 1, 'test' => 1, 'to' => 1, 'count' => 1, 'wordstest' => 1})
    end
  end

  context 'It is not case sensitive' do
    it 'Count same words with capital letter or not' do
      source = double('source', :read => 'First test, TEST. first AnothER tESt')
      words_counter = WordsCounterService.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 6
      expect(words_counter.distinct).to eq 3
      expect(words_counter.words).to include ({'first' => 2, 'test' => 3, 'another' => 1})
    end
  end

  context 'Remove restricted words' do
    it 'Do not count words with #blue' do
      source = double('source', :read => 'First test, blueberry TEST. first Blue, somethingblue, tESt')
      words_counter = WordsCounterService.new(source)
      words_counter.add_restricted_string('blue')
      words_counter.parse
      expect(words_counter.total).to eq 5
      expect(words_counter.distinct).to eq 2
      expect(words_counter.words).to include ({'first' => 2, 'test' => 3})
    end
    it 'Do not count words with #blue and #green' do
      source = double('source', :read => 'First test, blueberry TEST. first Blue, somethingblue, tESt green park y greenpeace')
      words_counter = WordsCounterService.new(source)
      words_counter.add_restricted_string('blue')
      words_counter.add_restricted_string('green')
      words_counter.parse
      expect(words_counter.total).to eq 7
      expect(words_counter.distinct).to eq 4
      expect(words_counter.words).to include ({'first' => 2, 'test' => 3, 'park' => 1, 'y' => 1})
    end
  end
end