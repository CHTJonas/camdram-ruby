require 'test_helper'

class SocietyTests < Minitest::Test
  def test_society_by_id
    society = @client.get_society(1)
    assert_equal 1, society.id
    assert_equal "Cambridge University Amateur Dramatic Club", society.name
    assert_equal "CUADC", society.short_name
    assert_equal "cambridge-university-amateur-dramatic-club", society.slug
    assert_equal "Founded in 1855, the Cambridge University Amateur Dramatic Club (or CUADC) is the oldest University dramatic society in England - and the largest dramatic society in Cambridge. We're at the very heart of one of the liveliest student theatre scenes in the country. We stage an exciting and diverse range of productions every term, most of them at the ADC Theatre in Park Street, where we are the resident company. We regularly stage shows at other Cambridge venues, annually at the Edinburgh Fringe and occasionally on tour abroad.\r\n\r\nFor more information, see the [CUADC website](https://www.cuadc.org) or contact the [CUADC president](mailto:president@cuadc.org)", society.description
    assert_equal "https://www.facebook.com/189141344500085", society.facebook_id
    assert_equal "472457773", society.twitter_id
    assert_equal society, society.refresh!
  end

  def test_society_by_slug
    society = @client.get_society("camdram")
    assert_equal 38, society.id
    assert_equal "Camdram", society.name
    assert_equal "Camdram", society.short_name
    assert_equal "1002481303", society.twitter_id
    assert_equal society, society.refresh!
  end

  def test_society_image
    society = @client.get_society(1)
    image = society.image
    assert_equal 3310, image.id
    assert_equal 1024, image.width
    assert_equal 1152, image.height
    assert_equal "5b33d9251b70a.png", image.filename
    assert_equal "png", image.extension
    assert_equal DateTime.parse("2018-06-27T19:36:21+00:00"), image.created_at
  end

  def test_society_news
    # Data is dynamic so hard to test - here goes...
    society = @client.get_society(1)
    news = society.news.first
    assert_equal true, news.created_at.is_a?(DateTime)
    assert_equal true, news.posted_at.is_a?(DateTime)
    assert_equal true, news.id.is_a?(Integer)
    assert_equal true, news.picture.is_a?(String) if news.picture
    assert_equal true, news.body.is_a?(String)
  end

  def test_society_shows
    society = @client.get_society('cambridge-american-stage-tour')
    shows = society.shows("2017-09-01", "2018-01-01")
    show = shows.first
    assert_equal 5823, show.id
    assert_equal "CAST 2017: A Midsummer Night's Dream", show.name
    assert_equal "William Shakespeare", show.author
    assert_equal "drama", show.category
    assert_equal "Cambridge American Stage Tour", show.societies.first.name
    assert_equal 5790, show.performances.first.id
    assert_equal "ADC Theatre", show.performances.first.venue.name
  end

  def test_society_diary
    society = @client.get_society('cambridge-american-stage-tour')
    diary = society.diary("2017-09-01", "2018-01-01")
    event = diary.events.first
    assert_equal DateTime.parse("2017-09-06T18:30:00+00:00"), event.start_at
    assert_nil event.repeat_until
  end
end
