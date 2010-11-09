#module Rails
#  module Generators
#    module Actions
#
#      attr_accessor :stategies
#      attr_reader :template_options, :file_exist?

      def initialize_templater
        @stategies = []
        @template_options = {}
      end

      def stategies
        @stategies
      end

      def execute_stategies
        stategies.each {|stategy| stategy.call }
      end
      
      def load_template(template)
        if @remote
          apply "http://github.com/blahutka/rails-templates/raw/master/#{template}"
        else
          unless file_exist?(recipe('setup.rb'))
            #git :clone =>  'git@github.com:blahutka/rails-templates.git lib/rails-templates'
          else
            #inside(recipe('')){git :pull => 'origin master'}
          end
          apply(recipe(template))
        end
      end

      def recipe(name)
        File.join File.dirname(__FILE__), name
      end


      def file_exist?(path)
        p = File.join(destination_root, path)
        if File.exist?(p)
          log :file, "File found: #{p}"
          return true
        else
          log :file, 'File not found' + p
          return false
        end
      end

#    end
#  end
#end