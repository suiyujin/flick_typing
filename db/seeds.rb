require 'csv'

def make_dummy_data(data)
  data[1..-1].map { |d| Hash[*data[0].zip(d).flatten] }
end

# teams
Team.create(make_dummy_data(CSV.read('db/seed_data/teams.csv')))
p 'teams inserted.'

# answers
Answer.create(make_dummy_data(CSV.read('db/seed_data/answers.csv')))
p 'answers inserted.'

# inputs
make_dummy_data(CSV.read('db/seed_data/inputs.csv')).each do |line|
  Input.create(line)
  sleep 1
end
p 'inputs inserted.'
