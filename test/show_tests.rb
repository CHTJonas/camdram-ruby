require 'test_helper'

class ShowTests < Minitest::Test
  def test_show_by_id
    show = @client.get_show(6514)
    assert_equal 6514, show.id
    assert_equal "This show is a dummy used by Camdram for testing purposes only.", show.description
    assert_equal "5b58b83bd534a.jpg", show.image.filename
    assert_equal 1024, show.image.width
    assert_equal "API Test 1", show.name
    assert_equal 29, show.performances.first.venue.id
    assert_equal "ADC Theatre", show.performances.first.venue.name
    assert_equal "1997-api-test-1", show.slug
    assert_equal 38, show.societies.first.id
    assert_equal "Camdram", show.societies.first.name
    assert_equal show, show.refresh!
  end

  def test_show_by_slug
    show = @client.get_show("1997-api-test-1")
    assert_equal 6514, show.id
    assert_equal "This show is a dummy used by Camdram for testing purposes only.", show.description
    assert_equal "5b58b83bd534a.jpg", show.image.filename
    assert_equal 1024, show.image.width
    assert_equal "API Test 1", show.name
    assert_equal 29, show.performances.first.venue.id
    assert_equal "ADC Theatre", show.performances.first.venue.name
    assert_equal 38, show.societies.first.id
    assert_equal "Camdram", show.societies.first.name
    assert_equal show, show.refresh!
  end

  def test_show_roles
    show = @client.get_show("2016-the-winter-s-tale")
    role = show.roles.first
    assert_equal "Will Bishop", role.person_name
    assert_equal "will-bishop", role.person_slug
    assert_equal 61624, role.id
    assert_equal "prod", role.type
    assert_equal "Director", role.role
    assert_equal 0, role.order
    assert_equal show.id, role.show.id
    assert_equal show.name, role.show.name
    assert_equal show.slug, role.show.slug
    assert_equal show.description, role.show.refresh!.description
    person = @client.get_person(role.person_slug)
    assert_equal person.id, role.person.id
    assert_equal person.name, role.person.name
    assert_equal person.slug, role.person.slug
  end
end
