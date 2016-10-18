module AidanIpsum
  PUNCTUATION = ['.', ',', '!']

  def self.sentence
    l = WordLoader.new
    l.quotes.shuffle!
    quotes_to_use = l.quotes.sample(rand(2..3))
    sentence = quotes_to_use.join(PUNCTUATION.sample + " ")
    sentence << "." unless PUNCTUATION.include?(sentence[-1])
    sanitise_sentence(sentence)
  end

  def self.paragraph(sentences = 5)
    paragraph = []
    sentences.times do |s|
      paragraph << self.sentence
    end
    paragraph.join(" ")
  end

  def self.quote
    l = WordLoader.new
    sanitise_sentence(l.quotes.shuffle!.sample)
  end

  def self.gibberish(words = 20)
    l = WordLoader.new
    all_words = l.quotes.join(" ").split(" ")
    all_words.shuffle!
    sanitise_sentence(all_words.sample(words).join(" "))
  end

  def self.bingo
    l = WordLoader.new
    bingo = Hash.new
    columns = [:a1, :a2, :a3,:b1, :b2, :b3,:c1, :c2, :c3]
    columns.each do |c|
      value = l.quotes.sample
      l.quotes.delete(value)
      bingo[c] = value
    end
    puts "*** Your AidanBingo card ***"
    puts " 1   #{bingo[:a1]} | #{bingo[:b1]} | #{bingo[:c1]}"
    puts "    ----------------------------------------------"
    puts " 2   #{bingo[:a2]} | #{bingo[:b2]} | #{bingo[:c2]}"
    puts "    ----------------------------------------------"
    puts " 3   #{bingo[:a3]} | #{bingo[:b3]} | #{bingo[:c3]}"
  end

  def self.sanitise_sentence(sentence)
    sentence.gsub(/([a-z])((?:[^.?!]|\.(?=[a-z]))*)/i) { $1.upcase + $2.rstrip }
  end

  def self.method_missing(method_sym, *arguments, &block)
    return "** puts up middle finger **"
  end

  class WordLoader
    attr_accessor :quotes

    def initialize
      self.quotes = []
      File.open(File.dirname(__FILE__) << '/aidan_ipsum/words.txt').each_line do |quote|
        self.quotes << quote.gsub!(/\n/, '')
      end
      self.quotes.compact!
    end
  end
end
