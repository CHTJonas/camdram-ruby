require 'test_helper'

class ClientTests < Minitest::Test

  # There is some real magic going on here. Not really sure why
  # some of the shows have start dates of -0001. There is a
  # special place reserved in hell for the data returned by the
  # Camdram API.

  def test_diary
    diary = @client.diary("2018-11-01", "2018-11-02")
    assert_equal Date.parse("2018-10-28"), diary.start_date
    assert_equal Date.parse("2018-11-04"), diary.end_date
    period = diary.periods.first
    assert_equal Date.parse("2018-09-30"), period.start_at
    assert_equal Date.parse("2018-12-02"), period.end_at
    assert_equal "Michaelmas Term 2018", period.text
    events = diary.events
    assert_equal 6238, events[2].id
    assert_equal 6466, events[2].show.id
    assert_equal "Witches", events[2].show.name
    assert_equal 30, events[2].venue.id
    assert_equal "Corpus Playroom", events[2].venue.name
  end

  def test_termly_diary
    diary = @client.termly_diary("2015", "lent-term")
    events = diary.events
    assert_equal 4247, events[0].id
    assert_equal 4068, events[0].show.id
    assert_equal "ETG 2014: Macbeth", events[0].show.name
    assert_equal 29, events[0].venue.id
    assert_equal "ADC Theatre", events[0].venue.name
  end
end
