require_relative "lisp_parser"

class LispInterpreter
  LISP_FUNCTIONS = {
    :+ => Proc.new { |args| args.reduce(:+) },
    :- => Proc.new { |args| args.reduce(:-) }
  }

  def self.evaluate(ast:)
    if ast.is_a?(Array)
      token = ast.shift
      if LISP_FUNCTIONS.has_key?(token)
        args = ast.map { |subtree| evaluate(ast: subtree) }
        LISP_FUNCTIONS[token].call(args)
      else
        raise StandardError, "Unexpected Lisp Token!!"
      end
    else
      ast
    end
  end
end
