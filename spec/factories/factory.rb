
class Factory
	class << self
		def build_list(count)
			result = []
			count.times do
				result << build
			end
			result
		end

		def sequence_number
			@sequence_number
		end

		def inc_sequence_number
			@sequence_number ||= 0
			@sequence_number += 1
		end

		def build
			inc_sequence_number
			create_fake
		end
	end
end