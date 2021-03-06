require "katagami/version"

require 'fileutils'

require 'active_support'
require 'active_support/core_ext'
require 'positive_basic_support'
require 'positive_number_support'

require "katagami/image"
require "katagami/image/file"
require "katagami/args"

module Katagami

  TOP_DIR = "/Users/shufujita/Creative Cloud Files/Materials/IseKatagami"

  def self.init
    set_dictionary_as_const
  end

  class << self

    private

    def set_dictionary_as_const
      csv_filename = "#{ TOP_DIR }/list.csv"
      ary = open( csv_filename , "r:windows-31j" ).read.split( /(?:\n|\r\n)/ )
      dict = ary.map { | row |
        num_s , title = row.encode( "UTF-8" ).split( /,/ )
        ::Katagami::Image.new( num_s.to_i , title )
      }
      const_set( :DICTIONARY , dict )

      return nil
    end

  end

  def self.select_and_copy_files( of: nil ,type_of: nil )
    method_or_words = of
    filetype = type_of

    raise unless filetype.string_or_symbol?

    args_send_to_each_image = ::Katagami::Args.set_args_of( method_or_words )
    dir_of_date = ::Time.now.strftime( "%Y%m%d_%H%M%S" )

    selected_images = DICTIONARY.select { | image | image.send( *args_send_to_each_image ) }

    # puts "args: #{ args_send_to_each_image.to_s }"

    selected_images.each do | image |
      puts image.class.name
      image.copy_file( to: dir_of_date , type_of: filetype )
    end

    puts ""
    puts "#{ selected_images.length} images"

    return nil
  end

end

__END__

# Katagami.init
# Katagami.select_and_copy_files( of:/波/ , type_of: :jpg )

class KatagamiList < Array

  def self.generate
    self.new( open( "#{File.dirname( __FILE__ ) }/list.csv" , "r:windows-31j" ).read.split( /\n/ ).map { | row |
      num_s , title = row.encode( "UTF-8" ).split( /,/ )
      Katagami.new( num_s.to_i , title )
    } )
  end

  def to_s( header )
    puts "● #{header}"
    puts ""
    self.each do | item |
      puts item.to_s
    end
    puts ""
    return nil
  end

  def select( &block )
    self.class.new( super( &block ) )
  end

  def files( all_files )
    self.map { | item | item.filename( all_files ) }
  end

end

katagami_list = KatagamiList.generate
all_files = Dir.glob( "#{ File.dirname( __FILE__ ) }/**/**.png" )

katagami_list.select( &:related_to_spring_flower_and_water? ).to_s( "Spring flower and water" )
# katagami_list.select { | item | item.related_to_spring_flower? and !( item.related_to_water? ) }.to_s( "Spring flower" )
# katagami_list.select { | item | item.related_to_water? and !( item.related_to_spring_flower? ) }.to_s( "Water" )

katagami_list.select( &:related_to_spring_flower_and_water? ).files( all_files ).each do | filename |
  new_filename = "C:/Users/Fujita Shu/Dropbox/Documents/Nagoya/Nagoya_201503/Materials/#{ File.basename( filename ) }"
  ::FileUtils.copy_file( filename , new_filename )
end
