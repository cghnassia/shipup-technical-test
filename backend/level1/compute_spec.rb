require "json"
require_relative "./compute"

describe "Compute" do
    it "output and expected output should be identicals" do
        output = compute("./data/input.json")
        expected_output = JSON.parse(File.read("./data/expected_output.json"))
        expect(output).to eq(expected_output)
    end
  end