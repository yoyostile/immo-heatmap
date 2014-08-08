class Kimono

  URL = 'https://www.kimonolabs.com/api/3fw96tv0?apikey=12f6f6024114494a5713c77e55b041da'

  def fetch
    cleaned_results
  end

  def create_apartments
    cleaned_results.each do |result|
      Apartment.create \
        title:    result["title"]["text"],
        url:      result["title"]["href"],
        address:  result["address"],
        rent:     result["rent"],
        size:     result["size"],
        rooms:    result["rooms"],
        is24_id:  result["id"]
    end
  end

  private

  def response
    @response ||= RestClient.get(Kimono::URL)
  end

  def json_response
    JSON.parse(response)
  end

  def results
    json_response['results']['results']
  end

  def cleaned_results
    res = []
    results.each do |result|
      result["id"] = result["title"]["href"].match(/\A.*expose\/(\d*)/)[1]
      result["address"] = result["address"].match(/\| (.*)/)[1]
      result["rent"] = result["rent"].gsub('.','').match(/\d*/)[0]
      result["size"] = result["size"].match(/\d*/)[0]
      result["rooms"] = result["rooms"].match(/\d*/)[0]
    end
  end

end
