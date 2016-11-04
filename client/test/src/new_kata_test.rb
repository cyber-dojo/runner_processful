require_relative './client_test_base'

class NewKataTest < ClientTestBase

  def self.hex_prefix; 'D2E7E'; end

  test 'C7A',
  "when image_name is valid new_kata(kata_id, image_name)'s status is zero" do
    new_kata
    assert_equal 0, status
    assert_equal '', stdout, json.to_s
    assert_equal '', stderr, json.to_s
  end

end