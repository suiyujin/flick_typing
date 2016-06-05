json.array!(@inputs) do |input|
  json.extract! input, :id, :text, :score, :time, :team_id, :answer_id
  json.url input_url(input, format: :json)
end
