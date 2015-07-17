module Katagami::Args

  def self.set_args_of( method_or_words )
    if method_or_words.string_or_symbol?
      method_searched = "related_to_#{ method_or_words }?"
      if methods_for_decion_of_image_instace.include?( method_searched )
        method_name = method_searched
        return method_name
      else
        searched_word = method_or_words
        return [ "related_to?" , searched_word ]
      end
    else
      return [ "related_to?" , method_or_words ].flatten
    end
  end

  class << self

    private

    def methods_for_decion_of_image_instace
      regexp = /\Arelated_to_(.+)\?\Z/
      ::Katagami::Image.private_instance_methods( false ).map( &:to_s ).select { | item |  regexp === item }
    end

  end

end
