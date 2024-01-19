module Mirrors
  def self.init_mirror
    # create required folder structure
    # with mkdir -p <folder>
  end

  def self.copy_file_to_mirrors(file, options = {})
    # create hash from file
    #
    # locale file in local storage
    #
    # check that the file path makes sense which should be copied
    #
    # get list of all mirrors
    #
    # for each mirror with mirror{ user, host }
    # (mirrors is coming from CONFIG[:mirrors])
    #
    # assemble remote user@host
    # assemble remote folder+filename
    #
    # init retry_count in case of errors
    #
    # copy file to mirror
    #
    # try and catch all of that
    # with incrementing retry count up to a limit
  end
end
