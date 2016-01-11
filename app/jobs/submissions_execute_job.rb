class SubmissionsExecuteJob < ActiveJob::Base
  queue_as :default

  def perform(submission)
    require 'digest/md5'
    require 'pathname'
    require 'docker'

    digest = Digest::MD5.new
    digest << submission.id.to_s
    digest << submission.code
    digest << submission.assignment.run_script

    folder = Pathname "/var/spool/e800/#{digest.hexdigest}"

    Dir.mkdir(folder.parent) unless Dir.exist?(folder.parent)
    Dir.mkdir(folder)

    (folder + 'e800_run.sh').open('w') do |f|
      f << submission.assignment.run_script << "\n"
    end

    (folder + 'code.txt').open('w') do |f|
      f << submission.code << "\n"
    end

    (folder + 'Dockerfile').open('w') do |f|
      f << "
      FROM phusion/baseimage:0.9.18

      # Use baseimage-docker's init system.
      CMD [\"/sbin/my_init\", \"--quiet\", \"--\", \"sh\", \"/root/e800_run.sh\"]

      # RUN apt-get update && apt-get install -y \

      WORKDIR /root
      COPY . .

      # Clean up APT when done.
      RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
      "
    end

    image = Docker::Image.build_from_dir folder.to_s, :t => "eyeballs/#{digest.hexdigest}"

    container = Docker::Container.create :Image => image.id

    container.start
    container.wait 10
    container.stop

    output = container.logs(stdout: true, stderr: true)
    output = output.gsub("\u0000", '')

    container.delete
    image.remove
    folder.rmtree

    submission.output = output
    submission.pending = false
    submission.save
  end
end
