require_relative "../lib/lisp_interpreter"

describe LispInterpreter do
  it "evaluates lisp code using +" do
    lisp_code = "(+ 2 2)"
    ast = LispParser.new(code: lisp_code).abstract_syntax_tree

    expect(described_class.evaluate(ast: ast)).to eq 4
  end

  it "evaluates lisp code using -" do
    lisp_code = "(- 5 2)"
    ast = LispParser.new(code: lisp_code).abstract_syntax_tree

    expect(described_class.evaluate(ast: ast)).to eq 3
  end

  it "evaluates nested lisp code" do
    lisp_code = "(+ 2 (+ 2 2))"
    ast = LispParser.new(code: lisp_code).abstract_syntax_tree

    expect(described_class.evaluate(ast: ast)).to eq 6
  end
end
