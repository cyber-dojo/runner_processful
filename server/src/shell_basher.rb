require 'open3'

class ShellBasher

  def initialize(parent)
    @log = parent.log
  end

  def assert_exec(command)
    stdout,stderr,status = exec(command)
    if status != success
      fail ArgumentError.new("command:#{command}")
    end
    [stdout,stderr]
  end

  def exec(command, verbose = log)
    begin
      stdout,stderr,r = Open3.capture3(command)
      status = r.exitstatus
      if status != success
        verbose << line
        verbose << "COMMAND:#{command}"
        verbose << "STATUS:#{status}"
        verbose << "STDOUT:#{stdout}"
        verbose << "STDERR:#{stderr}"
      end
      [stdout, stderr, status]
    rescue StandardError => error
      log << line
      log << "COMMAND:#{command}"
      log << "RAISED-CLASS:#{error.class.name}"
      log << "RAISED-TO_S:#{error.to_s}"
      raise error
    end
  end

  def success
    0
  end

  private

  attr_reader :log

  def line
    '-' * 40
  end

end

