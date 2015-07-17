class Katagami::Image

  def initialize( number , title )
    raise unless number.integer? and number <= 1600
    @number = number
    @title = title
  end

  def related_to?( *args )
    args.any? { | item | item === @title }
  end

  def related_to_spring_flower?
    related_to?( /(?:桜|梅)/ )
    # /桜/ === title and /松/ !~ title
  end

  def related_to_water?
    related_to?( /(?:青海波|海|水|波)/ )
  end

  def related_to_spring_flower_and_water?
    related_to_spring_flower? and related_to_water?
  end

  def to_s
    [ @number.to_s.rjust(4) , @title ].join( " " )
  end


  def copy_file( type_of: nil , to: nil )
    filetype = type_of
    dir_basename = to

    raise unless filetype.string_or_symbol?
    raise unless dir_basename.string?

    puts "Katagami::Image\#copy"

    # file_instance = ::Katagami::Image::File.new( @number , filetype )
    # file_instance.copy_file( to: dir_basename )
  end

end
