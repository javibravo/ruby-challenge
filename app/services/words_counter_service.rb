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

  def initialize(file)
    @file = file
    @restricted_strings = Array.new
  end

  # Words that contains restricted string will not be taken into account.
  def add_restricted_string(string)
    @restricted_strings.push(string)
  end

  def parse
    @total = 0
    @distinct = 0
    @words = Hash.new(0)

    list_of_words = @file.read.split
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
      if !is_restricted_string(cleaned_word)
        @words[cleaned_word] += 1
        @total += 1
      end
    end
  end

  def is_restricted_string(word)
    if @restricted_strings.length > 0
      regex_content = @restricted_strings.join('|')
      if word.match(/#{regex_content}/i)
        return true
      end
    end
    false
  end

end