export 
	secondsIn,
	minutesIn,
	hoursIn,
	daysIn,
	weeksIn


# ---------------------------------------------------------------------------------- #
#
TimeTypes = Union{Time, Nanosecond, Microsecond, Millisecond, Second, Minute, Hour, Day, Week}

# ---------------------------------------------------------------------------------- #
#
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

minutesIn(t::TimeTypes) = secondsIn(t) / 60.
hoursIn(t::TimeTypes) = secondsIn(t) / 3600.
daysIn(t::TimeTypes) = hoursIn(t) / 24.
weeksIn(t::TimeTypes) = daysIn(t) / 7.


# ---------------------------------------------------------------------------------- #