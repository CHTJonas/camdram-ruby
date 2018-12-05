require 'test_helper'

class ClientTests < MiniTest::Unit::TestCase

  # There is some real magic going on here. Not really sure why
  # some of the shows have start dates of -0001. There is a
  # special place reserved in hell for the data returned by the
  # Camdram API.

  def test_diary
    diary = @client.diary("2005-01-01", "2005-01-02")
    events = diary.events
    assert_equal 6503, events.first.id
    assert_equal 1840, events.first.show.id
    assert_equal "ADC Theatre", events.first.venue.name
    assert_equal 6577, events[2].id
    assert_equal "1970-01-01T19:30:00+00:00", events[2].time
    assert_equal 3899, events[2].show.id
    assert_equal 90, events[2].venue.id
  end

  def test_termly_diary
    diary = @client.termly_diary("2001", "summer-vacation")
    events = diary.events
    assert_equal 6455, events[0].id
    assert_equal "2003-12-06T00:00:00+00:00", events[0].end_date
    assert_equal 10, events[0].show.id
    assert_equal "Alice in Wonderland", events[0].show.name
    assert_equal 29, events[0].venue.id
    assert_equal "ADC Theatre", events[0].venue.name
    assert_equal 6503, events[1].id
    assert_equal "2008-12-06T00:00:00+00:00", events[1].end_date
    assert_equal 1840, events[1].show.id
    assert_equal "Theseus and the Minotaur: ADC/Footlights Panto 2008", events[1].show.name
    assert_equal 29, events[1].venue.id
    assert_equal "ADC Theatre", events[1].venue.name
  end
end
