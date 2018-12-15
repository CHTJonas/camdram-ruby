require 'test_helper'
require 'date'

class OrganisationTests < Minitest::Test

  def test_organisation
    organisation = @client.get_org(1)
    assert_equal 1, organisation.id
    assert_equal "Cambridge University Amateur Dramatic Club", organisation.name
    assert_equal "CUADC", organisation.short_name
    assert_equal "cambridge-university-amateur-dramatic-club", organisation.slug
    assert_equal "Founded in 1855, the Cambridge University Amateur Dramatic Club (or CUADC) is the oldest University dramatic society in England - and the largest dramatic society in Cambridge. We're at the very heart of one of the liveliest student theatre scenes in the country. We stage an exciting and diverse range of productions every term, most of them at the ADC Theatre in Park Street, where we are the resident company. We regularly stage shows at other Cambridge venues, annually at the Edinburgh Fringe and occasionally on tour abroad.\r\n\r\nFor more information, see the [L:http://www.cuadc.org;CUADC website] or contact the [L:mailto:president@cuadc.org;CUADC president]", organisation.description
    assert_equal "189141344500085", organisation.facebook_id
    assert_equal "472457773", organisation.twitter_id
  end

  def test_organisation_image
    organisation = @client.get_org(1)
    image = organisation.image
    assert_equal 1577, image.id
    assert_equal 1024, image.width
    assert_equal 1152, image.height
    assert_equal "5b33d9251b70a.png", image.filename
    assert_equal "png", image.extension
    assert_equal DateTime.parse("2018-06-27T19:36:21+00:00"), image.created_at
  end

  def test_organisation_news
    # Data is dynamic so hard to test - here goes...
    organisation = @client.get_org(1)
    news = organisation.news.first
    assert_equal true, news.created_at.is_a?(DateTime)
    assert_equal true, news.posted_at.is_a?(DateTime)
    assert_equal true, news.id.is_a?(Integer)
    assert_equal true, news.picture.is_a?(String) if news.picture
    assert_equal true, news.body.is_a?(String)
  end

  def test_organisation_shows
    organisation = @client.get_org('cambridge-american-stage-tour')
    shows = organisation.shows("2017-09-01", "2018-01-01")
    show = shows.first
    assert_equal 5823, show.id
    assert_equal "CAST 2017: A Midsummer Night's Dream", show.name
    assert_equal "William Shakespeare", show.author
    assert_equal "drama", show.category
    assert_equal "Cambridge American Stage Tour", show.societies.first.name
    assert_equal 5790, show.performances.first.id
    assert_equal "ADC Theatre", show.performances.first.venue.name
  end

  def test_organisation_diary
    organisation = @client.get_org('cambridge-american-stage-tour')
    diary = organisation.diary("2017-09-01", "2018-01-01")
    event = diary.events.first
    assert_equal Date.parse("2017-09-06"), event.start_date
    assert_equal Date.parse("2017-09-06"), event.end_date
    assert_equal DateTime.parse("1970-01-01T19:30:00+00:00"), event.time
  end

end
