require_relative './lib_test_base'
require_relative './docker_runner_helpers'

class DockerRunnerLanguageTest < LibTestBase

  def self.hex
    '9D930'
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'CDE',
  '[C(gcc),assert] (an Ubuntu-based image) runs and has',
  'the user nobody and',
  'the group nogroup' do
    @expected = "Assertion failed: answer() == 42"
    assert_runs 'gcc_assert'
    assert user_nobody_exists?
    assert group_nogroup_exists?
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '5F0',
  '[Ruby,MiniTest] (an Alpine-based image) runs and has',
  'the user nobody and',
  'the group nogroup' do
    @expected = '1 runs, 1 assertions, 1 failures, 0 errors, 0 skips'
    assert_runs 'ruby_mini_test'
    assert user_nobody_exists?
    assert group_nogroup_exists?
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'C87',
  '[C#,Moq] runs (it explicitly names /sandbox in cyber-dojo.sh)' do
    @expected = 'Tests run: 1, Errors: 0, Failures: 1, Inconclusive: 0'
    assert_runs 'csharp_moq'
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '182',
  '[C#-NUnit] runs (it needs to pick up HOME from the current user)' do
    @expected = 'Tests run: 1, Errors: 0, Failures: 1, Inconclusive: 0'
    assert_runs 'csharp_nunit'
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  def assert_runs(dir)
    hello
    output, _ = assert_execute(files(dir))
    assert output.include?(@expected), output
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  def user_nobody_exists?
    output, _ = assert_execute({ 'cyber-dojo.sh' => 'getent passwd nobody' })
    output.start_with?('nobody')
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  def group_nogroup_exists?
    output, _ = assert_execute({ 'cyber-dojo.sh' => 'getent group nogroup' })
    output.start_with?('nogroup')
  end

  include DockerRunnerHelpers

end

