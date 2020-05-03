class TravelController < ApplicationController
  def search
    countries = find_country(params[:country])

    unless countries
      flash[:alert] = 'Country not found'
      return render action:index

      @country = countries.first
      @weather = find_weather(@country['capital'], @country['alpha2code'])
    end

    def find_weather(city, country_code)
      query = URI.encode("#{city}, #{country_code}")
      request_api(
          "https://community-open-weather-app.p.rapidapi.com/forecast?q=#{query}"
      )
    end

    private

    def request_api(url)
      response = Excon.get(
          url,
          headers: {
              'X-RapidAPI-Host' => URI.parse(url).host,
              'X-RapidAPI-Key' => ENV.fetch('7033fedaa6msh3e977c7a6f22333p1f0631jsn7d1f5e9c39e8')
          }
      )

      return nil if response.status != 200

      JSON.parse(response.body)
    end

    def find_country(name)
      request_api(
          "https://restcountries-v1.p.rapidapi.com/name/#{URI.encode(name)}"
      )
    end

end