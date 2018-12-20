require 'test_helper'

class TimePeriodTests < Minitest::Test
  def test_time_period
    period = @client.time_periods(2018).first
    assert_equal "Lent Term 2018", period.full_name
    assert_equal "Lent Term", period.name
    assert_equal "Lent", period.short_name
    assert_equal "lent-term", period.slug
    assert_equal DateTime.parse("2018-01-14T00:00:00+00:00"), period.start_at
    assert_equal DateTime.parse("2018-03-25T00:00:00+00:00"), period.end_at
  end
end
