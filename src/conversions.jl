# ---------------------------------------------------------------------------------- #
#
@doc """
Extend Unitful's `uconvert` to enable directly counting selected units of time from an object of type `Time`.

# Input
. `t::Time`: object of type `Time` \\

# Output 
. Unitful object in the desired unit of time.
"""
uconvert(u::Unitful.Units, t::TimeTypes) = secondsIn(t) * u"s" |> u

# ---------------------------------------------------------------------------------- #
#
@doc """
"""
function Base.convert(::Type{Time}, time::Unitful.Time) 
	t = nothing

	try 
		dt = convert(Nanosecond, time)
		t = isnothing(t) ? dt : t + dt
		return canonicalize(t)
	catch
	end

	try 
		dt = convert(Microsecond, time)
		t = isnothing(t) ? dt : t + dt
		return canonicalize(t)
	catch
	end

	try 
		dt = convert(Millisecond, time)
		t = isnothing(t) ? dt : t + dt
		return canonicalize(t)
	catch
	end

	try 
		dt = convert(Second, time)
		t = isnothing(t) ? dt : t + dt
		return canonicalize(t)
	catch
	end

	try 
		dt = convert(Minute, time)
		t = isnothing(t) ? dt : t + dt
		return canonicalize(t)
	catch
	end

	try 
		dt = convert(Hour, time)
		t = isnothing(t) ? dt : t + dt
		return canonicalize(t)
	catch
	end

	try 
		dt = convert(Day, time)
		t = isnothing(t) ? dt : t + dt
		return canonicalize(t)
	catch
	end

	try 
		dt = convert(Week, time)
		t = isnothing(t) ? dt : t + dt
		return canonicalize(t)
	catch
	end

	if isnothing(t) 
		throw(ErrorException("Problem resolving the time scale required."))
	end

	return t
end





# ---------------------------------------------------------------------------------- #