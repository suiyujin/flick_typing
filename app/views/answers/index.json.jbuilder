json.array!(@answers) do |answer|
  json.extract! answer, :id, :text
  json.url answer_url(answer, format: :json)
end
