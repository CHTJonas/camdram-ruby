require 'test_helper'

class PersonTests < Minitest::Test
  def test_person_by_id
    person = @client.get_person(13865)
    assert_equal 13865, person.id
    assert_equal "Charlie Jonas", person.name
    assert_equal "charlie-jonas", person.slug
  end

  def test_person_by_slug
    person = @client.get_person("charlie-jonas")
    assert_equal 13865, person.id
    assert_equal "Charlie Jonas", person.name
    assert_equal "charlie-jonas", person.slug
  end

  def test_person_roles
    person = @client.get_person("charlie-jonas")
    role = person.roles.first
    assert_equal "Charlie Jonas", role.person_name
    assert_equal "charlie-jonas", role.person_slug
    assert_equal 58004, role.id
    assert_equal "prod", role.type
    assert_equal "Technician", role.role
    assert_equal 0, role.order
    assert_equal 5101, role.show.id
    assert_equal "ETG 2015: Twelfth Night", role.show.name
    assert_equal "etg-2015-twelfth-night", role.show.slug
    assert_equal "9f7045a48117589bff407a0d757ddf2e", role.show.refresh!.image.filename
    assert_equal 13865, role.person.id
    assert_equal "Charlie Jonas", role.person.name
    assert_equal "charlie-jonas", role.person.slug
    assert_equal person.name, role.person.refresh!.name
  end
end
