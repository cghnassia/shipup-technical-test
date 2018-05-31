require "json"
require "date"

file = File.read("data/input.json")
data = JSON.parse(file)

deliveries = {}
data["carriers"].each do |carrier|
    deliveries[carrier["code"]] = carrier["delivery_promise"]
end

result = data["packages"].map do |package|
    promise = deliveries[package["carrier"]]
    shipping_date = Date.parse(package["shipping_date"]) + promise + 1

    { 
        package_id: package["id"], 
        expected_delivery: shipping_date.to_s 
    }
end

result = {
    deliveries: result
}

puts result.to_json