require 'test_helper'

class ClientTests < Minitest::Test

  def test_client
    assert_equal "https://www.camdram.net", @client.base_url
    assert_equal "Camdram Ruby v#{@client.version}", @client.user_agent
  end

  def test_client_show_byid
    show = @client.get_show(6514)
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

  def test_client_show_byslug
    show = @client.get_show("1997-api-test-1")
    assert_equal 6514, show.id
    assert_equal "This show is a dummy used by Camdram for testing purposes only.", show.description
    assert_equal "5b58b83bd534a.jpg", show.image.filename
    assert_equal 1024, show.image.width
    assert_equal "API Test 1", show.name
    assert_equal "Camdram", show.other_society
    assert_equal "ADC Theatre", show.other_venue
    assert_equal 29, show.performances.first.venue.id
    assert_equal 38, show.society.id
    assert_equal "Camdram", show.society.name
    assert_equal 29, show.venue.id
    assert_equal "ADC Theatre", show.venue.name
  end

  def test_client_organisation_byid
    org = @client.get_org(38)
    assert_equal "Camdram", org.name
    assert_equal "Camdram", org.short_name
    assert_equal "camdram", org.slug
    assert_equal "1002481303", org.twitter_id
  end

  def test_client_organisation_byslug
    org = @client.get_org("camdram")
    assert_equal 38, org.id
    assert_equal "Camdram", org.name
    assert_equal "Camdram", org.short_name
    assert_equal "1002481303", org.twitter_id
  end

  def test_client_venue_byid
    venue = @client.get_venue(29)
    assert_equal "ADC Theatre", venue.name
    assert_equal "ADC Theatre", venue.short_name
    assert_equal "adc-theatre", venue.slug
    assert_equal "33348320992", venue.facebook_id
    assert_equal "36725639", venue.twitter_id
  end

  def test_client_venue_byslug
    venue = @client.get_venue("adc-theatre")
    assert_equal 29, venue.id
    assert_equal "ADC Theatre", venue.name
    assert_equal "ADC Theatre", venue.short_name
    assert_equal "33348320992", venue.facebook_id
    assert_equal "36725639", venue.twitter_id
  end
end
