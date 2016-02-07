class WordsCounter

  attr_reader :total
  attr_reader :distinct
  attr_reader :words

  def initialize(source)
    @source = source
  end

  def parse
    words = @source.read.split
    word_times = Hash.new(0)
    total_words = 0
    words.each do |word|
      clean_word = word.gsub(/[^a-zA-Z0-9\s]/i, '')
      if clean_word.length != 0
        word_times[clean_word] += 1
        total_words += 1
      end
    end
    @total = total_words
    @distinct = word_times.length
    @words = word_times
  end

end