# ----------------------------------------------------------------------------------------------- #
#
@doc """
Extend Unitful's `uconvert` to enable directly counting selected units of time from an object of type `Time`.

# Input
. `t::Time`: object of type `Time` \\

# Output 
. Unitful object in the desired unit of time.
"""
uconvert(u::Unitful.Units, t::TimeTypes) = secondsIn(t) * u"s" |> u


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Extend Julia's `Base` function `convert` to handle any type of time.
"""
function Base.convert(::Type{CompoundPeriod}, time::Unitful.Time; referenceUnit = u"d", truncationUnit = u"ms")
	unitDict = Dict(
		u"wk" => Week,
		u"d" => Day,
		u"hr" => Hour,
		u"minute" => Minute,
		u"s" => Second,
		u"ms" => Millisecond,
		u"μs" => Microsecond,
		u"ns" => Nanosecond
		)
	uR = referenceUnit
	uT = truncationUnit
	if uR ∉ keys(unitDict) || uT ∉ keys(unitDict)
		throw(KeyError("Unknown units are being used for time conversion."))
	end
	
	R = unitDict[uR]
	T = unitDict[uT]
	integer = floor(ustrip(time |> uR)) * uR
	decimal = ((time |> uR) - integer) |> uT
	return canonicalize(CompoundPeriod(R(ustrip(integer)), T(round(ustrip(decimal)))))
end


# ----------------------------------------------------------------------------------------------- #