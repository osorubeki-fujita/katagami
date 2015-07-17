class Katagami::Image::File

  def initialize( number , filetype )
    @number = number
    set_filetype( filetype )
  end

  def copy_file( to: nil )
    raise unless to.string?
    dir = to
    before = filename
    after = filename_new( dir )

    puts "#{ before } => #{ after }"

    ::FileUtils.copy_file( before , after )

    return nil
  end

  private

  def set_filetype( filetype )
    case filetype.to_s.downcase
    when "jpeg" , "jpg"
      sym = :jpeg
    when "png"
      sym = :png
    else
      raise "The variable #{ file_type } is not valid."
    end
    @filetype = sym
    return nil
  end

  def filename
  "#{ ::Katagami::TOP_DIR }/Images/#{ filetype_dir }/#{ dir_grouped_by_file_number }/#{ file_basename }"
  end

  def filetype_dir
    @filetype.to_s.upcase
  end

  def dir_grouped_by_file_number
    ( @number / 200 + 1 ) * 200
  end

  def file_basename
    "#{ @number }.#{ file_ext }"
  end

  def file_ext
    case @filetype
    when :jpeg
      "jpg"
    when :png
      "png"
    end
  end

  # @!group The name of new file

  def filename_new( dir )
  "#{ ::Katagami::TOP_DIR }/Copied_files/#{ dir }/#{ file_basename }"
  end

  # @!endgroup

end
