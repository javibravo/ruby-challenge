# WordsCounterService
#
# Service used to parse and ASCII file and count number of words. It
# counts duplications of each word.
#
# Required : File object.
class WordsCounterService

  attr_reader :total
  attr_reader :distinct
  attr_reader :words

  def initialize(source)
    @source = source
  end

  def parse
    @total = 0
    @distinct = 0
    @words = Hash.new(0)

    list_of_words = @source.read.split
    list_of_words.each do |word|
      parse_word(word)
    end

    @distinct = @words.length
  end

  private

  def parse_word(word)
    cleaned_word = word.gsub(/[^a-zA-Z0-9\s]/i, '')
    if cleaned_word.length > 0
      cleaned_word = cleaned_word.downcase
      @words[cleaned_word] += 1
      @total += 1
    end
  end

end