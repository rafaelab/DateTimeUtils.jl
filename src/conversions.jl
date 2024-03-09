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
This particular method converts `Time` to `CompoundPeriod`.
"""
Base.convert(::Type{CompoundPeriod}, t::Time) = Hour(t) + Minute(t) + Second(t) + Millisecond(t) + Microsecond(t) + Nanosecond(t)


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Extend Julia's `Base` function `convert` to handle any type of time.
This particular method converts `Date` to `CompoundPeriod`.
"""
Base.convert(::Type{CompoundPeriod}, d::Date) = Year(d) + Month(d) + Day(d)


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Extend Julia's `Base` function `convert` to handle any type of time.
This particular method converts `DateTime` to `CompoundPeriod`.
"""
Base.convert(::Type{CompoundPeriod}, dt::DateTime) = convert(CompoundPeriod, Time(dt)) + convert(CompoundPeriod, Date(dt))


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Extend Julia's `Base` function `convert` to handle any type of time.
This one converts a `Unitful` time to a `CompoundPeriod`.

# Input
. `type`: type of object for conversion (e.g. `Dates.CompoundPeriod`) \\
. `time`: the time with `Unitful` units \\``
. `referenceUnit`: the time unit to be used (e.g., day, seconds, etc) \\
. `truncationUnit`: at which time unit should the time be truncated.
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
#
@doc """
Extend Julia's `Base` function `convert` to handle any type of time.
It converts a `CompoundPeriod` to `Unitful`.

# Input
. `type`: type of object for conversion (e.g. `Dates.CompoundPeriod`) \\
. `time`: the time with `Unitful` units \\``
. `referenceUnit`: the time unit to be used (e.g., day, seconds, etc) \\
. `truncationUnit`: at which time unit should the time be truncated.
"""
function Base.convert(::Type{Unitful.Time}, time::CompoundPeriod; referenceUnit = u"s", truncationUnit = u"ns")

	unitDict = Dict(
		Year => u"yr",
		Month => u"yr",
		Week => u"wk",
		Day => u"d",
		Hour => u"hr",
		Minute => u"minute",
		Second => u"s",
		Millisecond => u"ms",
		Microsecond => u"μs",
		Nanosecond => u"ns"
		)

	t = 0. * referenceUnit
	for component in time.periods
		if typeof(component) == Month
			# accumulate days of months
			for i = 1 : component.value - 1
				dt = Year ∉ time.periods ? DateTime(1, i) : DateTime(time.periods[1].value, i)
				t += component.value * unitDict[Day] * daysinmonth(dt)
			end
		else
			t += component.value * unitDict[typeof(component)]
		end
	end

	return t |> referenceUnit
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Extend Julia's `Base` function `convert` to handle any type of time.
It converts a `DateTime`/`Date`/`Time` to `Unitful`.
Note that there is no real reference of T0, such that conversions might lead to weird results.

# Input
. `type`: type of object for conversion (e.g. `Dates.CompoundPeriod`) \\
. `time`: the time with `Unitful` units \\``
. `referenceUnit`: the time unit to be used (e.g., day, seconds, etc) \\
. `truncationUnit`: at which time unit should the time be truncated.
"""
function Base.convert(::Type{Unitful.Time}, time::Union{Date, Time, DateTime}; referenceUnit = u"s", truncationUnit = u"ns") 
	t = convert(CompoundPeriod, time)
	return convert(Unitful.Time, t; referenceUnit = referenceUnit, truncationUnit = truncationUnit)
end



# ----------------------------------------------------------------------------------------------- #