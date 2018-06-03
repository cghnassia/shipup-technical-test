require "json"
require_relative "./compute"

describe "Compute" do
    it "output and expected output for level 1 should be identicals" do
        output = compute("./level1/data/input.json")
        expected_output = JSON.parse(File.read("./level1/data/expected_output.json"))
        expect(output).to eq(expected_output)
    end

    it "output and expected output for level 2 should be identicals" do
        output = compute("./level2/data/input.json")
        expected_output = JSON.parse(File.read("./level2/data/expected_output.json"))
        expect(output).to eq(expected_output)
    end

    it "output and expected output for level 3 should be identicals" do
        output = compute("./level3/data/input.json")
        expected_output = JSON.parse(File.read("./level3/data/expected_output.json"))
        expect(output).to eq(expected_output)
    end
  end