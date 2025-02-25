# frozen_string_literal: true

require 'minitest/autorun'
require 'mcif_460_generator'
require 'byebug'

class MCIF460GeneratorTest < Minitest::Test
  
  def test_valid_person_types
    debugger 
    mcif =  MCIF460Generator.new('')
    valid_types = ('A'..'P').to_a + (1..9).to_a.map(&:to_s)
    valid_types.each do |type|
      assert_equal type.upcase, mcif.person_type(type)
    end
  end
  def test_invalid_person_types
    invalid_types = ['Q', '0', '@', nil, '']
    invalid_types.each do |type|
      assert_raises(RuntimeError) { MCIF460Generator.person_type(type) }
    end
  end
  def test_edge_cases
    assert_raises(RuntimeError) { MCIF460Generator.person_type(nil) }
    assert_raises(RuntimeError) { MCIF460Generator.person_type('') }
    assert_raises(RuntimeError) { MCIF460Generator.person_type(' ') }
  end
end

# require 'minitest/autorun'
# class PersonTypeTest < Minitest::Test
#   def test_valid_person_types
#     valid_types = ('A'..'P').to_a + (1..9).to_a.map(&:to_s)
#     valid_types.each do |type|
#       assert_equal type.upcase, MCIF460Generator.person_type(type)
#     end
#   end
#   def test_invalid_person_types
#     invalid_types = ['Q', '0', '@', nil, '']
#     invalid_types.each do |type|
#       assert_raises(RuntimeError) { MCIF460Generator.person_type(type) }
#     end
#   end
#   def test_edge_cases
#     assert_raises(RuntimeError) { MCIF460Generator.person_type(nil) }
#     assert_raises(RuntimeError) { MCIF460Generator.person_type('') }
#     assert_raises(RuntimeError) { MCIF460Generator.person_type(' ') }
#   end
# end