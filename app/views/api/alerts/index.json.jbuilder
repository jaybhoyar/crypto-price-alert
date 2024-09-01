json.alerts @alerts do |alert|
  json.id alert.id
  json.coin alert.coin
  json.status alert.status
  json.target_price alert.target_price
  json.created_at alert.created_at
end

json.current_page @alerts.current_page
json.total_pages @alerts.total_pages
json.total_count @alerts.total_count
