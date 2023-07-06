
# ---------------------------------------------------------------------------------- #
#
@doc """
Extend Unitful's `uconvert` to enable directly counting selected units of time from an object of type `Time`.

# Input
. `t::Time`: object of type `Time` \\

# Output 
. Unitful object in the desired unit of time.
"""
Unitful.uconvert(u::Unitful.Units, t::TimeTypes) = secondsIn(t) * u"s" |> u

# ---------------------------------------------------------------------------------- #