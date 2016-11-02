require 'sinatra/base'
require 'json'

require_relative './externals'
require_relative './docker_runner'
require_relative './string_cleaner'
require_relative './string_truncater'

class MicroService < Sinatra::Base

  post '/new_kata'    do; jasoned { runner.new_kata(kata_id, image_name) }; end
  post '/old_kata'    do; jasoned { runner.old_kata(kata_id, image_name) }; end

  post '/new_avatar'  do; jasoned { runner.new_avatar(kata_id, avatar_name) }; end
  post '/old_avatar'  do; jasoned { runner.old_avatar(kata_id, avatar_name) }; end

  post '/run' do
    args = []
    args << image_name
    args << kata_id
    args << avatar_name
    args << max_seconds
    args << deleted_filenames
    args << changed_files
    jasoned { runner.run(*args) }
  end

  private

  include Externals
  def runner; DockerRunner.new(self); end

  def args; @args ||= request_body_args; end
  def image_name;        args['image_name' ];       end
  def kata_id;           args['kata_id'    ];       end
  def avatar_name;       args['avatar_name'];       end
  def max_seconds;       args['max_seconds'];       end
  def deleted_filenames; args['deleted_filenames']; end
  def changed_files;     args['changed_files'];     end

  def request_body_args
    request.body.rewind
    JSON.parse(request.body.read)
  end

  include StringCleaner
  include StringTruncater

  def jasoned
    content_type :json
    begin
      stdout,stderr,status = yield
    rescue StandardError => error
      stdout,stderr,status = '', error.to_s, :error
    end
    { stdout:truncated(cleaned(stdout)),
      stderr:truncated(cleaned(stderr)),
      status:status
    }.to_json
  end

end


