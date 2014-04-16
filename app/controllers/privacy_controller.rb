class PrivacyController < ApplicationController
layout 'newIndex'
  def index
    @banners = Banner.find(:all)
    @banners.map {|b|
        class << b
                attr_accessor :trailer
        end
        @movie = Movie.find(b.movie_id)
        b.trailer = @movie[:trailer]
        b
    }

    #limit news
    $news = $news[0..2]
  end
end
