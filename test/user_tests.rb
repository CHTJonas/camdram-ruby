require 'test_helper'

class UserTests < Minitest::Test
  def test_user
    user = @client.user
    assert_equal 3807, user.id
    assert_equal "Charlie Jonas", user.name
    assert_equal "charlie@charliejonas.co.uk", user.email
  end

  def test_user_shows
    show = @client.user.get_shows.first
    assert_equal 6514, show.id
    assert_equal "This show is a dummy used by Camdram for testing purposes only.", show.description
    assert_equal "5dd80dad3502e.jpeg", show.image.filename
    assert_equal 1920, show.image.width
    assert_equal "ÁPÏ Test 1", show.name
    assert_equal 29, show.performances.first.venue.id
    assert_equal "ADC Theatre", show.performances.first.venue.name
    assert_equal "1997-api-test-1", show.slug
    assert_equal 38, show.societies.first.id
    assert_equal "Camdram", show.societies.first.name
  end

  def test_user_societies
    society = @client.user.get_societies.first
    assert_equal 38, society.id
    assert_equal "Camdram", society.name
    assert_equal "Camdram", society.short_name
    assert_equal "camdram", society.slug
    assert_equal "1002481303", society.twitter_id
  end

  # This test requires being added as an ADC venue administrator on Camdram
  # def test_user_venues
  #   venue = @client.user.get_venues.first
  #   assert_equal 29, venue.id
  #   assert_equal "ADC Theatre", venue.name
  #   assert_equal "ADC Theatre", venue.short_name
  #   assert_equal "adc-theatre", venue.slug
  #   assert_equal "33348320992", venue.facebook_id
  #   assert_equal "36725639", venue.twitter_id
  # end
end
