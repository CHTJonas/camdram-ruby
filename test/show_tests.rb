require 'test_helper'

class ShowTests < Minitest::Test
  def test_show_by_id
    show = @client.get_show(6514)
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
    assert_equal show, show.refresh!
  end

  def test_show_by_slug
    show = @client.get_show("1997-api-test-1")
    assert_equal 6514, show.id
    assert_equal "This show is a dummy used by Camdram for testing purposes only.", show.description
    assert_equal "5dd80dad3502e.jpeg", show.image.filename
    assert_equal 1920, show.image.width
    assert_equal "ÁPÏ Test 1", show.name
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

  def test_show_embedded_fields
    show = @client.get_show("cuadc-footlights-pantomime-2019-red-riding-hood")
    assert_equal 1, show.societies[0].id
    assert_equal 4, show.societies[1].id
    assert_equal 2080, show.image.id
    assert_equal "5d9cd49aa2666.jpg", show.image.filename
    assert_equal "#c80f0f", show.theme_color
  end
end
