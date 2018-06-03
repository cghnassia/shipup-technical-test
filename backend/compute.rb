require "json"
require "date"

def compute(input_file)
    file = File.read(input_file)
    data = JSON.parse(file)
    
    deliveries = {}
    data["carriers"].each do |carrier|
        deliveries[carrier["code"]] = { 
            delivery_promise: carrier["delivery_promise"],
            saturday_deliveries: carrier["saturday_deliveries"],
            oversea_delay_threshold: carrier["oversea_delay_threshold"]
        }
    end
    
    result = data["packages"].map do |package|
        carrier_data = deliveries[package["carrier"]]
        shipping_date = Date.parse(package["shipping_date"]) 
        delivery_date = shipping_date
        delivery_promise = carrier_data[:delivery_promise]

        if data["country_distance"]
            origin_country = package["origin_country"]
            destination_country = package["destination_country"]
            if origin_country != destination_country
                distance = data["country_distance"][origin_country][destination_country]
                oversea_delay = distance / carrier_data[:oversea_delay_threshold]
            else
                oversea_delay = 0
            end

            delivery_promise += oversea_delay
        end

        i = 0
        while i <= delivery_promise do
            delivery_date += 1
            unless delivery_date.sunday? || (delivery_date.saturday? && carrier_data[:saturday_deliveries] === false)
                i += 1
            end
        end

       
        item = { 
            "package_id" => package["id"], 
            "expected_delivery" => delivery_date.to_s
        }

        if data["country_distance"] 
            item["oversea_delay"] = oversea_delay
        end

        item
    end
    
    { "deliveries" => result }
end