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
          unless file_exist?('lib/rails-templates/setup.rb')
            git :clone =>  'git@github.com:blahutka/rails-templates.git lib/rails-templates'
          else
            inside('lib/rails-templates'){git :pull => 'origin master'}
          end
          apply(File.join(destination_root,'lib/rails-templates', template))
        end
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