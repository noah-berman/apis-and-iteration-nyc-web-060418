require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request

film_array = []
api_link = 'http://www.swapi.co/api/people/'


  while true

    all_characters = RestClient.get(api_link)
    character_hash = JSON.parse(all_characters)

    character_hash["results"].find do |attributes|
      film_array = attributes["films"]
    end

    if film_array.length > 0
      return film_array
    else
      api_link = character_hash["next"]
    end
  end

end

# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.

def film_api_request(api_array)
  # Need to store film_hash and then extract the individual attributes into
  # a new array of hashes
  film_data_hash = []
  api_array.each do |film_url|
    film_data = RestClient.get(film_url)
    film_data_hash  << JSON.parse(film_data)
  end
    film_data_hash
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each.with_index do |movie, i|
      puts "#{i + 1}. #{movie["title"]}"
  end
end

def show_character_movies(character)
  unformatted_films_hash = get_character_movies_from_api(character)
  formatted_films_hash = film_api_request(unformatted_films_hash)
  parse_character_movies(formatted_films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
