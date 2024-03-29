require 'test_helper'

class VenueTests < Minitest::Test
  def test_venue_by_id
    venue = @client.get_venue(29)
    assert_equal 29, venue.id
    assert_equal "ADC Theatre", venue.name
    assert_equal "ADC Theatre", venue.short_name
    assert_equal "adc-theatre", venue.slug
    assert_equal "Park Street, Cambridge", venue.address
    assert_equal "https://www.facebook.com/33348320992", venue.facebook_id
    assert_equal "36725639", venue.twitter_id
    assert_equal venue, venue.refresh!
  end

  def test_venue_by_slug
    venue = @client.get_venue("adc-theatre")
    assert_equal 29, venue.id
    assert_equal "ADC Theatre", venue.name
    assert_equal "ADC Theatre", venue.short_name
    assert_equal "adc-theatre", venue.slug
    assert_equal "Park Street, Cambridge", venue.address
    assert_equal "https://www.facebook.com/33348320992", venue.facebook_id
    assert_equal "36725639", venue.twitter_id
    assert_equal venue, venue.refresh!
  end

  def test_venue_image
    venue = @client.get_venue(29)
    image = venue.image
    assert_equal 1775, image.id
    assert_equal 1024, image.width
    assert_equal 1024, image.height
    assert_equal "5c0d110e0c51d.png", image.filename
    assert_equal "png", image.extension
    assert_equal DateTime.parse("2018-12-09T12:56:46+00:00"), image.created_at
  end

  def test_venue_news
    # Data is dynamic so hard to test - here goes...
    venue = @client.get_venue(43)
    news = venue.news.first
    assert_equal true, news.created_at.is_a?(DateTime)
    assert_equal true, news.posted_at.is_a?(DateTime)
    assert_equal true, news.id.is_a?(Integer)
    assert_equal true, news.picture.is_a?(String) if news.picture
    assert_equal true, news.body.is_a?(String)
  end

  def test_venue_shows
    venue = @client.get_venue('fitzpatrick-hall')
    assert_equal "Queens'", venue.college
    shows = venue.shows("2017-02-15", "2017-02-18")
    show = shows.first
    assert_equal 5827, show.id
    assert_equal "The Deep Blue Sea", show.name
    assert_equal "Terence Rattigan", show.author
    assert_equal "drama", show.category
    assert_equal "BATS", show.societies.first.name
    assert_equal 5404, show.performances.first.id
    assert_equal "Fitzpatrick Hall", show.performances.first.venue.name
  end

  def test_venue_diary
    venue = @client.get_venue('fitzpatrick-hall')
    diary = venue.diary("2017-02-15", "2017-02-18")
    event = diary.events.first
    assert_equal DateTime.parse("2017-02-16T19:30:00+00:00"), event.start_at
    assert_equal Date.parse("2017-02-18"), event.repeat_until
    assert_equal 42, event.venue.id
    assert_equal "Silver Street, Cambridge", event.venue.refresh!.address
  end
end
