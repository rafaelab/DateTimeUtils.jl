export 
	nanosecondsIn,
	microsecondsIn,
	millisecondsIn,
	secondsIn,
	minutesIn,
	hoursIn,
	daysIn,
	weeksIn


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Useful alias encompassing time types defined in `Dates.jl`.
"""
TimeTypes = Union{Time, Nanosecond, Microsecond, Millisecond, Second, Minute, Hour, Day, Week}


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	secondsIn(t)

Count the number of seconds within a given time.

# Input
. `t`: any object of a type in `TimeTypes` 
"""
secondsIn(t::Nanosecond) = 1e-9 * t.value
secondsIn(t::Microsecond) = 1e-6 * t.value
secondsIn(t::Millisecond) = 1e-3 * t.value
secondsIn(t::Second) = t.value
secondsIn(t::Minute) = 60. * t.value
secondsIn(t::Hour) = 3600. * t.value
secondsIn(t::Day) = 86400. * t.value
secondsIn(t::Week) = 604800 * t.value
secondsIn(t::Month) = daysinmonth(t) * secondsIn(Day(1))
 
function secondsIn(t::Time)
	h = secondsIn(Hour(t))
	m = secondsIn(Minute(t))
	s = secondsIn(Second(t))
	ms = secondsIn(Millisecond(t))
	mus = secondsIn(Microsecond(t))
	ns = secondsIn(Nanosecond(t))
	return h + m + s + ms + mus + ns
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	minutesIn(t)

Count the number of minutes within a given time.

# Input
. `t`: any object of a type in `TimeTypes` 
"""
minutesIn(t::TimeTypes) = secondsIn(t) / 60.


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	hoursIn(t)

Count the number of hours within a given time.

# Input
. `t`: any object of a type in `TimeTypes` 
"""
hoursIn(t::TimeTypes) = secondsIn(t) / 3600.


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	daysIn(t)

Count the number of days within a given time.

# Input
. `t`: any object of a type in `TimeTypes` 
"""
daysIn(t::TimeTypes) = hoursIn(t) / 24.


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	weeksIn(t)

Count the number of weeks within a given time.

# Input
. `t`: any object of a type in `TimeTypes` 
"""
weeksIn(t::TimeTypes) = daysIn(t) / 7.

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	millisecondsIn(t)

Count the number of milliseconds within a given time.

# Input
. `t`: any object of a type in `TimeTypes` 
"""
millisecondsIn(t::TimeTypes) = 1e3 * secondsIn(t)


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	microsecondsIn(t)

Count the number of microseconds within a given time.

# Input
. `t`: any object of a type in `TimeTypes` 
"""
microsecondsIn(t::TimeTypes) = 1e6 * secondsIn(t)


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	nanosecondsIn(t)

Count the number of nanoseconds within a given time.

# Input
. `t`: any object of a type in `TimeTypes` 
"""
nanosecondsIn(t::TimeTypes) = 1e9 * secondsIn(t)


# ----------------------------------------------------------------------------------------------- #