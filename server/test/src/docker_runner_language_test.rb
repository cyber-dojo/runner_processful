require_relative './lib_test_base'
require_relative './docker_runner_helpers'

class DockerRunnerLanguageTest < LibTestBase

  def self.hex
    '9D930'
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'CDE',
  'Ubuntu-based image [C(gcc),assert]' do
    runner_start
    expected = "All tests passed\n"
    files = starting_files('gcc_assert')
    actual = runner_run(files)
    assert_equal expected, actual
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '5F0',
  'Alpine-based [Ruby,MiniTest]' do
    runner_start
    expected = "All tests passed\n"
    files = starting_files('ruby_mini_test')
    output = runner_run(files)
    assert output.include?('1 runs, 1 assertions, 0 failures, 0 errors, 0 skips')
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  # test
  # (F#,NUnit) which explicitly names /sandbox in cyber-dojo.sh

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  # test
  # (C#-NUnit) which needs to pick up HOME from the _current_ user

  private

  include DockerRunnerHelpers

end

