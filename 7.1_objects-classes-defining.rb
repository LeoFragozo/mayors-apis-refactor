class Phrase

	attr_accessor :content

	def initialize(content)
		@content = content
	end

	def palindrome?
	  processed_content = content.downcase
	  processed_content == processed_content.reverse
	end

	def louder
		content.upcase
	end
end