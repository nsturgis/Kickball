require 'csv'
require 'pry'
require 'sinatra'

teams_info = []
CSV.foreach("lackp_starting_rosters.csv",headers:true,header_converters: :symbol) do |row|
  teams_info << row.to_hash
end

def pic_team (array)
  teams = []
  array.each do |row|
  teams << row[:team]
 end
 teams.uniq
end

def find_players (teams)
  group = []

  CSV.foreach("lackp_starting_rosters.csv", headers:true,header_converters: :symbol) do |row|
    if row[:team] == teams
      group << row.to_hash
    end
  end
  group
end

def find_positions(position)
  positions = []

  CSV.foreach("lackp_starting_rosters.csv", headers: true, header_converters: :symbol) do |row|
    if row[:position] == position
      positions << row.to_hash
    end
  end
  positions
end



get '/' do
  @team = pic_team(teams_info)
erb :kickball
end

get '/team/:team_name' do
@player = find_players(params[:team_name])
erb :player
end

get '/positions/:position' do
@position = find_positions(params[:position])
erb :positions
end
