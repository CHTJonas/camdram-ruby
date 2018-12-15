require 'test_helper'

class SearchTests < Minitest::Test

  def test_search_show
    entity = @client.search("API Test")[0].entity
    assert_equal 6514, entity.id
    assert_equal "This show is a dummy used by Camdram for testing purposes only.", entity.description
    assert_equal "5b58b83bd534a.jpg", entity.image.filename
    assert_equal 1024, entity.image.width
    assert_equal "API Test 1", entity.name
    assert_equal "Camdram", entity.other_society
    assert_equal "ADC Theatre", entity.other_venue
    assert_equal 29, entity.performances.first.venue.id
    assert_equal "1997-api-test-1", entity.slug
    assert_equal 38, entity.society.id
    assert_equal "Camdram", entity.society.name
    assert_equal 29, entity.venue.id
    assert_equal "ADC Theatre", entity.venue.name
  end

  def test_search_society
    entity = @client.search("CUADC")[0].entity
    assert_equal 1, entity.id
    assert_equal "Cambridge University Amateur Dramatic Club", entity.name
    assert_equal "CUADC", entity.short_name
    assert_equal "cambridge-university-amateur-dramatic-club", entity.slug
    assert_equal "189141344500085", entity.facebook_id
    assert_equal "472457773", entity.twitter_id
  end

  def test_search_venue
    entity = @client.search("ADC Theatre")[0].entity
    assert_equal 29, entity.id
    assert_equal "ADC Theatre", entity.name
    assert_equal "ADC Theatre", entity.short_name
    assert_equal "adc-theatre", entity.slug
    assert_equal "33348320992", entity.facebook_id
    assert_equal "36725639", entity.twitter_id
  end

  def test_search_person
    entity = @client.search("Charlie Jonas")[0].entity
    assert_equal 13865, entity.id
    assert_equal "Charlie Jonas", entity.name
    assert_equal "charlie-jonas", entity.slug
  end

end
