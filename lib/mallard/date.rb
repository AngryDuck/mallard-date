require 'date'

module Mallard
    # Mallard::Date has a fairly simple naming convention:
    # s = start, e = end
    # d = day, w = week, m = month, q = quarter, y = year
    # i = in
    # t = this, l = last, [0-9] = N period ago.  stmly and stm1y are the same thing.  The only difference is that stmly is explicitly coded while stm1y is handled
    # via method_missing and stmXy
    # generally, methods return a Mallard::Date object.
    # if the time period is spelt out rather than abbreviated (e. g. #lyear), then the method returns the value of just that period rather than
    # a date object
    # also, any method with an 'i' in it will return numeric rather than a date
    class Date < ::Date
        # days in this month
        def ditm    # for the uninitiated:  make a new date on the 1st of the month, add 1 month, subtract 1 day, return the day field
            ((Mallard::Date.new(year, month) >> 1) - 1).day
        end

        # start of this month
        def stm
            Mallard::Date.new(year, month)
        end

        # end of this month
        def etm
            (Mallard::Date.new(year, month) >> 1) - 1
        end

        # returns self
        def date
            self
        end

        # start this week
        def stw
            self - wday
        end

        # end this week
        def etw
            stw + 6
        end

        # start last week
        def slw
            stw - 7
        end

        # end last week
        def elw
            etw - 7
        end

        # start this quarter
        def stq
            Mallard::Date.new(year, (quarter - 1) * 3 + 1)
        end

        # end this quarter
        def etq
            (Mallard::Date.new(year, quarter * 3) >> 1) - 1
        end

        # current quarter
        def quarter
            (month - 1) / 3 + 1
        end

        # last year
        def lyear
            year - 1
        end

        # days in this month last year
        def ditmly
            ((Mallard::Date.new(year - 1, month) >> 1) - 1).day
        end

        # start this month last year
        def stmly
            Mallard::Date.new(year - 1, month)
        end

        # end this month last year
        def etmly
            (Mallard::Date.new(year - 1, month) >> 1) - 1
        end

        # days in last month
        def dilm
            (Mallard::Date.new(year, month) - 1).day
        end

        # start last month
        def slm
            Mallard::Date.new(year, month) << 1
        end

        # end last month
        def elm
            Mallard::Date.new(year, month) - 1
        end

        def method_missing(meth, *args, &block)
            if meth.to_s =~ /^s([0-9]+)m$/
                sXm($1.to_i)
            elsif meth.to_s =~ /^e([0-9]+)m$/
                eXm($1.to_i)
            elsif meth.to_s =~ /^s([0-9]+)w$/
                sXw($1.to_i)
            elsif meth.to_s =~ /^e([0-9]+)w$/
                eXw($1.to_i)
            elsif meth.to_s =~ /^di([0-9]+)m$/
                diXm($1.to_i)
            elsif meth.to_s =~ /^year([0-9]+)$/
                yearX($1.to_i)
            elsif meth.to_s =~ /^ditm([0-9]+)y$/
                ditmXy($1.to_i)
            elsif meth.to_s =~ /^stm([0-9]+)y$/
                stmXy($1.to_i)
            elsif meth.to_s =~ /^etm([0-9]+)y$/
                etmXy($1.to_i)
            else
                super
            end
        end

        def respond_to?(meth)
            if meth.to_s =~ /^s([0-9]+)m$/
                true
            elsif meth.to_s =~ /^e([0-9]+)m$/
                true
            elsif meth.to_s =~ /^s([0-9]+)w$/
                true
            elsif meth.to_s =~ /^e([0-9]+)w$/
                true
            elsif meth.to_s =~ /^di([0-9]+)m$/
                true
            elsif meth.to_s =~ /^year([0-9]+)$/
                true
            elsif meth.to_s =~ /^ditm([0-9]+)y$/
                true
            elsif meth.to_s =~ /^stm([0-9]+)y$/
                true
            elsif meth.to_s =~ /^etm([0-9]+)y$/
                true
            else
                super
            end
        end

        # start X months ago
        def sXm (n)
            slm << (n - 1)
        end

        # end X months ago
        def eXm (n)
            (stm << (n - 1)) - 1
        end

        # start X weeks ago
        def sXw (n)
            stw - n * 7
        end

        # end X weeks ago
        def eXw (n)
            sXw(n) + 6
        end

        # days in X months ago
        def diXm (n)
            sXm(n).ditm
        end

        # X years ago
        def yearX (n)
            year - n
        end

        # days in this month X years ago
        def ditmXy (n)
            ((Mallard::Date.new(year - n, month) >> 1) - 1).day
        end

        # start this month X years ago
        def stmXy (n)
            Mallard::Date.new(year - n, month)
        end

        # end this month X years ago
        def etmXy (n)
            (Mallard::Date.new(year - n, month) >> 1) - 1
        end

        # jan 1st this year
        def jan1ty
            Mallard::Date.new(year, 1, 1)
        end

        # jan 1st last year
        def jan1ly
            Mallard::Date.new(lyear, 1, 1)
        end

        # the 'week' year, or in another words what year said week is week number X in.  Will only be different from year in early January
        def wyear
            stw.year
        end

        # the week year for last year.  See #wyear
        def wlyear
            stw.year - 1
        end

        # current week number
        def week
            ((stw - sty) / 7).to_i + 1  # added the to_i to eliminate some weirdness when converting to string
        end

        # this week last year.  Same as week unless we're in the last week of a 53 week year, in which case it's 52
        def twly
            week == 53 ? 52 : week
        end

        # start this year, from the week perspective, not simply Jan 1st
        def sty
            Mallard::Date.new(wyear) + (7 - Mallard::Date.new(wyear).wday) % 7
        end

        # start last year
        def sly
            Mallard::Date.new(wlyear, 1, 1) + (7 - Mallard::Date.new(wlyear, 1, 1).wday) % 7
        end

        # start this week last year
        def stwly
            sly + (twly - 1) * 7
        end

        # end this week last year
        def etwly
            stwly + 6
        end

        # this day last year
        def tdly
            stwly + wday
        end

        def to_str
            strftime('%F')
        end

        def today
            Mallard::Date.today
        end

        def conv (meth)
            if meth.class == Fixnum
                return self + meth
            elsif meth == meth.to_i.to_s
                return self + meth.to_i
            else
                return self.send(meth.to_sym)
            end
        end
    end
end
