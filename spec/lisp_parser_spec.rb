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
end
