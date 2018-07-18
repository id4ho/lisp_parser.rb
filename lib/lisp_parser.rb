class LispParser
  attr_reader :code
  def initialize(code:)
    @code = code
  end

  def tokens
    @tokens ||= pad_parentheses.split
  end

  def abstract_syntax_tree
    @abstract_syntax_tree ||= parse_tokens(tokens: tokens)
  end

  private

  def pad_parentheses
    code.gsub("(", " ( ").gsub(")", " ) ")
  end
end
