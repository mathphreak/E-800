class SubmissionsExecuteJob < ActiveJob::Base
  queue_as :default

  def perform(submission)
    require 'pathname'
    require 'docker'

    folder = create_folder submission
    folder = fill_folder folder, submission

    with_container_output(folder) do |output|
      submission.output = output
      submission.pending = false
      submission.save
    end
  end

  private

  def calc_hash(submission)
    require 'digest/md5'

    digest = Digest::MD5.new
    digest << submission.id.to_s
    digest << submission.code
    digest << submission.assignment.run_script

    digest.hexdigest
  end

  def create_folder(submission)
    folder = Pathname "/var/spool/e800/#{calc_hash submission}"

    Dir.mkdir(folder.parent) unless Dir.exist?(folder.parent)
    Dir.mkdir(folder)

    folder
  end

  def fill_folder(folder, submission)
    sub_write(folder, 'e800_run.sh') do |f|
      f << submission.assignment.run_script << "\n"
    end

    sub_write(folder, 'code.txt') do |f|
      f << submission.code << "\n"
    end

    sub_write(folder, 'Dockerfile') do |f|
      f << (Pathname(__dir__) + 'Dockerfile').read
    end

    folder
  end

  def with_container_output(folder)
    image = Docker::Image.build_from_dir folder.to_s
    container = Docker::Container.create Image: image.id

    container.start
    container.wait 10

    output = container.logs(stdout: true, stderr: true)

    # The below line of code is what's technically known as a
    # "terrible workaround to a problem that should not exist at all."
    #
    # The Docker API module is returning logs with ASCII control character
    # nonsense at the beginning of lines for reasons that aren't clear.
    # As far as I can tell, this regex matches ASCII control characters that
    # aren't \n.
    output.gsub!(/[\p{C}&&[^\n]]/, '')

    yield output

    container.delete force: true
    image.remove force: true
    folder.rmtree
  end

  def sub_write(folder, path)
    (folder + path).open('w') do |f|
      yield f
    end
  end
end
