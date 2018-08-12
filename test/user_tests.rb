require 'test_helper'

class UserTests < MiniTest::Unit::TestCase
  def test_user
    user = @client.user
    assert_equal 3807, user.id
    assert_equal "Charlie Jonas", user.name
    assert_equal "charlie@charliejonas.co.uk", user.email
  end

  def test_get_shows
    user = @client.user
    show = user.get_shows.first
    assert_equal 6514, show.id
    assert_equal "This show is a dummy used by Camdram for testing purposes only.", show.description
    assert_equal "5b58b83bd534a.jpg", show.image.filename
    assert_equal 1024, show.image.width
    assert_equal "API Test 1", show.name
    assert_equal "Camdram", show.other_society
    assert_equal "ADC Theatre", show.other_venue
    assert_equal 29, show.performances.first.venue.id
    assert_equal "1997-api-test-1", show.slug
    assert_equal 38, show.society.id
    assert_equal "Camdram", show.society.name
    assert_equal 29, show.venue.id
    assert_equal "ADC Theatre", show.venue.name
  end

  def test_get_organisations
    user = @client.user
    org = user.get_orgs.first
    assert_equal 38, org.id
    assert_equal "Camdram", org.name
    assert_equal "Camdram", org.short_name
    assert_equal "camdram", org.slug
    assert_equal "1002481303", org.twitter_id
  end
end
