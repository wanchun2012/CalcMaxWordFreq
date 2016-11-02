#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :content
  attr_reader :line_number
  attr_reader :highest_wf_count
  attr_reader :highest_wf_words

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize(content, line_number) 
    @line_number = line_number
    @content = content
    @highest_wf_count = 0
    @highest_wf_words = []
    self.calculate_word_frequency(@content)
  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency(content) 
    # Split text line into word array
    words = content.split()
    h = Hash.new(0)
    # Count frequency
    words.each { |word| h[word.downcase] += 1 }
    sorted_h = h.sort_by {|k,v| v}.reverse.to_h
    # Get max
    count_max = sorted_h.values[0]
    @highest_wf_count = count_max
    sorted_h.each_pair { |key, value|  
      if value == count_max
        @highest_wf_words.push(key)
      else
        break
      end
    }
  end

  def highest_wf_words()
    @highest_wf_words
  end
end

#  Implement a class called Solution. 
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  attr_reader :analyzers
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  attr_reader :highest_count_across_lines
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  attr_reader :highest_count_words_across_lines
  #  equal to the highest_count_across_lines determined previously.

  def initialize() 
    @analyzers = []
  end

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format
  
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file
  def analyze_file()
    line_number = 1
    if File.exist? 'test.txt'
      File.foreach( 'test.txt' ) do |content|
        la = LineAnalyzer.new(content, line_number)
        puts content
        @analyzers.push(la)
        line_number += 1
      end
    end
  end

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = []
    @analyzers.each do |la|
      if la.highest_wf_count > @highest_count_across_lines 
        @highest_count_across_lines = la.highest_wf_count
      end
    end
    @analyzers.each do |la|
      if la.highest_wf_count == @highest_count_across_lines
        puts "#{la.highest_wf_words} (appears in line #{la.line_number})"
        @highest_count_words_across_lines.push(la)
      end
    end
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines()
      p "calculates highest count across lines to be #{ @highest_count_across_lines}"
      words = []
      @highest_count_words_across_lines.each do |la|
        words.push(la.highest_wf_words)
      end
      words.flatten!
      p "calculates highest count words across lines to be #{words}" 
  end

  solution = Solution.new
  solution.analyze_file()
  solution.calculate_line_with_highest_frequency()
  solution.print_highest_word_frequency_across_lines()

end
