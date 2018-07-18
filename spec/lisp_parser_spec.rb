require_relative "../lib/lisp_parser"
require "spec_helper"

describe LispParser do
  describe "#tokens" do
    it "splits the code string into tokens" do
      lisp_code = "(+ 1 2)"
      lisp_parser = described_class.new(code: lisp_code)

      tokens = lisp_parser.tokens

      expect(tokens).to eq ["(", "+", "1", "2", ")"]
    end

    it "handles cases with extra whitespace" do
      lisp_code = " ( + 1   2)"
      lisp_parser = described_class.new(code: lisp_code)

      tokens = lisp_parser.tokens

      expect(tokens).to eq ["(", "+", "1", "2", ")"]
    end
  end

  describe "#parse_tokens" do
    it "returns an nil for an empty string" do
      lisp_code = ""
      lisp_parser = described_class.new(code: lisp_code)

      ast = lisp_parser.abstract_syntax_tree

      expect(ast).to be_nil
    end

    it "returns an empty AST for an empty function call" do
      lisp_code = "()"
      lisp_parser = described_class.new(code: lisp_code)

      ast = lisp_parser.abstract_syntax_tree

      expect(ast).to eq []
    end

    it "creates an AST from lisp code" do
      lisp_code = "(+ 1 2)"
      lisp_parser = described_class.new(code: lisp_code)

      ast = lisp_parser.abstract_syntax_tree

      expect(ast).to eq [:+, 1, 2]
    end

    it "handles nested expressions" do
      lisp_code = "(+ (* 3 4) 1 2)"
      lisp_parser = described_class.new(code: lisp_code)

      ast = lisp_parser.abstract_syntax_tree

      expect(ast).to eq [:+, [:*, 3, 4], 1, 2]
    end
  end
end
