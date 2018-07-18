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

  def parse_tokens(tokens:, ast: nil)
    # puts "called parse_tokens with tokens: #{tokens.inspect}, ast: #{ast.inspect}"
    if token = tokens.shift
      if token == "("
        expression_length = sub_expression_length(tokens: tokens)
        expression = tokens.shift(expression_length)
        tokens.shift # drop closing paren
        sub_expression = parse_tokens(tokens: expression, ast: [])
        if ast.nil?
          ast = parse_tokens(tokens: tokens, ast: sub_expression)
        else
          ast << sub_expression
          parse_tokens(tokens: tokens, ast: ast)
        end
      else
        ast << symbolize(string: token)
        parse_tokens(tokens: tokens, ast: ast)
      end
    end

    ast
  end

  private

  def sub_expression_length(tokens:)
    paren_depth = 1
    expression_length = 0
    while paren_depth > 0
      if tokens[expression_length] == "("
        paren_depth += 1
      elsif tokens[expression_length] == ")"
        paren_depth -= 1
      end
      expression_length += 1
    end
    expression_length - 1 # for the closing paren
  end

  def symbolize(string:)
    if string.to_i != 0 && string.ord != "0".ord
      string.to_i
    else
      string.to_sym
    end
  end

  def pad_parentheses
    code.gsub("(", " ( ").gsub(")", " ) ")
  end
end
