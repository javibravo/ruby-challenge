require 'rails_helper'

RSpec.describe WordsCounter, "#Basic" do
  context "Most simple text" do
    it "counts each occurence of words" do
      source = double("source", :read => "First test to count words test")
      words_counter = WordsCounter.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 6
      expect(words_counter.distinct).to eq 5
      expect(words_counter.words).to include ({"First" => 1, "test" => 2, "to" => 1, "count" => 1, "words" => 1})
    end
  end
  context "With multiple white spaces " do
    it "counts each occurence of words" do
      source = double(
          "source",
          :read => "First    test to  count     words
                    test"
      )
      words_counter = WordsCounter.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 6
      expect(words_counter.distinct).to eq 5
      expect(words_counter.words).to include ({"First" => 1, "test" => 2, "to" => 1, "count" => 1, "words" => 1})
    end
  end
  context "With punctuation marks" do
    it "counts each occurence of words" do
      source = double("source", :read => "First test, to count. words test. re-play")
      words_counter = WordsCounter.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 7
      expect(words_counter.distinct).to eq 6
      expect(words_counter.words).to include ({"First" => 1, "test" => 2, "to" => 1, "count" => 1, "words" => 1, "replay" => 1})
    end
  end
  context "With more punctuation marks" do
    it "counts each occurence of words" do
      source = double("source", :read => "First test, to count. words?test")
      words_counter = WordsCounter.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 5
      expect(words_counter.distinct).to eq 5
      expect(words_counter.words).to include ({"First" => 1, "test" => 1, "to" => 1, "count" => 1, "wordstest" => 1})
    end
  end
  context "With isolated punctuation marks" do
    it "counts each occurence of words" do
      source = double("source", :read => "First test, ** to count. ( words?test")
      words_counter = WordsCounter.new(source)
      words_counter.parse
      expect(words_counter.total).to eq 5
      expect(words_counter.distinct).to eq 5
      expect(words_counter.words).to include ({"First" => 1, "test" => 1, "to" => 1, "count" => 1, "wordstest" => 1})
    end
  end
end