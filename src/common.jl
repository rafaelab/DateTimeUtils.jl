# ----------------------------------------------------------------------------------------------- #
#
@doc """
	getNumberOfDecimalDigits(number)

Basic auxiliary function that returns the number of decimal digits of any number.
"""
function getNumberOfDecimalDigits(number::Real)
	numberString = "$number"
	parts = split(numberString, ".")
	nDigits = ifelse(length(parts) == 2, length(parts[2]), 0)
	return nDigits
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	getNumberOfIntegerDigits(number)

Basic auxiliary function that returns the number without any decimal digits.
Note that no rounding is performed.
"""
function getNumberOfIntegerDigits(number::Real)
	numberString = "$number"
	parts = split(numberString, ".")
	nDigits = ifelse(length(parts) == 2, length(parts[1]), length(numberString))
	return nDigits
end


# ----------------------------------------------------------------------------------------------- #