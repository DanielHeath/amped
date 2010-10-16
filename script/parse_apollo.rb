require 'json'
hash = JSON.parse File.read('public/apollo.json')
hash["items"].each do |item|
  puts ""
  puts ""
  puts ""
  puts ""
  puts ""
  
  
  
  puts "$('#poi_localisation_name').val('#{item['title']}')"
  puts "$('#poi_localisation_poi_attributes_type').val('See')"
  
  review = []
  next unless item['item_detail']['significance_statement'] and item['summary'] and item['item_detail']['production_notes']

  item['summary'].each_line { |line| review << line.strip }
  item['item_detail']['production_notes'].each_line { |line| review << line.strip }
  item['item_detail']['significance_statement'].each_line { |line| review << line.strip }

  review.map! {|e| e.gsub("'", '"')}
  
  puts "$('#poi_localisation_review_attributes_summary').html('<p>#{review.join("</p><p>")}</p>')"
  puts "$('#poi_localisation_review_attributes_detail').html('')"
end
