require 'spec_helper'

describe Mallard::Date do
    before(:all) do
        @feb    = Mallard::Date.parse("2012-02-17")
        @jan    = Mallard::Date.parse("2012-01-17")
        @dec    = Mallard::Date.parse("2011-12-17")
        @nye    = Mallard::Date.parse("2011-12-31")
    end

    describe "#year" do
        it "returns the current year" do
            @feb.year.should eql 2012
        end
    end

    describe "#lyear" do
        it "returns last year" do
            @feb.lyear.should eql 2011
        end
    end

    describe "#year2" do
        it "returns two years ago" do
            @feb.year2.should eql 2010
        end
    end

    describe "#month" do
        it "returns the current month" do
            @feb.month.should eql 2
        end
    end

    describe "#day" do
        it "returns the current day" do
            @feb.day.should eql 17
        end
    end

    describe "#ditm" do
        it "returns the number of days in the current month" do
            @feb.ditm.should eql 29
            @dec.ditm.should eql 31
        end
    end

    describe "#ditmly" do
        it "returns the number of days in the current month from last year" do
            @feb.ditmly.should eql 28
        end
    end

    describe "#ditm2y" do
        it "returns the number of days in the current month from two years ago" do
            @feb.ditm2y.should eql 28
        end
    end

    describe "#dilm" do
        it "returns the number of days in last month" do
            @feb.dilm.should eql 31
            @jan.dilm.should eql 31
        end
    end

    describe "#di2m" do
        it "returns the number of days in two months ago" do
            @feb.di2m.should eql 31
            @jan.di2m.should eql 30
        end
    end

    describe "#stm" do
        it "returns the start of this month" do
            @feb.stm.should eql Mallard::Date.parse("2012-02-01")
            @dec.stm.should eql Mallard::Date.parse("2011-12-01")
        end
    end

    describe "#etm" do
        it "returns the end of this month" do
            @feb.etm.should eql Mallard::Date.parse("2012-02-29")
            @dec.etm.should eql Mallard::Date.parse("2011-12-31")
        end
    end

    describe "#stmly" do
        it "returns the start of this month" do
            @feb.stmly.should eql Mallard::Date.parse("2011-02-01")
        end
    end

    describe "#etmly" do
        it "returns the end of this month" do
            @feb.etmly.should eql Mallard::Date.parse("2011-02-28")
        end
    end

    describe "#slm" do
        it "returns the start of last month" do
            @feb.slm.should eql Mallard::Date.parse("2012-01-01")
            @jan.slm.should eql Mallard::Date.parse("2011-12-01")
        end
    end

    describe "#elm" do
        it "returns the end of last month" do
            @feb.elm.should eql Mallard::Date.parse("2012-01-31")
            @jan.elm.should eql Mallard::Date.parse("2011-12-31")
        end
    end

    describe "#s2m" do
        it "returns the start of two months ago" do
            @feb.s2m.should eql Mallard::Date.parse("2011-12-01")
        end
    end

    describe "#e2m" do
        it "returns the end of two months ago" do
            @feb.e2m.should eql Mallard::Date.parse("2011-12-31")
        end
    end

    describe "#sXm" do
        it "returns the start of X months ago" do
            @feb.s15m.should eql Mallard::Date.parse("2010-11-01")
            @feb.s27m.should eql Mallard::Date.parse("2009-11-01")
        end
    end

    describe "#date" do
        it "returns self" do
            @feb.date.should eql @feb
        end
    end

    describe "#stw" do
        it "returns the start of this week" do
            @feb.stw.should eql Mallard::Date.parse("2012-02-12")
        end
    end

    describe "#etw" do
        it "returns the end of this week" do
            @feb.etw.should eql Mallard::Date.parse("2012-02-18")
        end
    end

    describe "#slw" do
        it "returns the start of last week" do
            @feb.slw.should eql Mallard::Date.parse("2012-02-05")
        end
    end

    describe "#elw" do
        it "returns the end of last week" do
            @feb.elw.should eql Mallard::Date.parse("2012-02-11")
        end
    end

    describe "#s2w" do
        it "returns the start of two weeks ago" do
            @feb.s2w.should eql Mallard::Date.parse("2012-01-29")
        end
    end

    describe "#e2w" do
        it "returns the end of two weeks ago" do
            @feb.e2w.should eql Mallard::Date.parse("2012-02-04")
        end
    end

    describe "#stwly" do
        it "returns the start of this week last year" do
            @feb.stwly.should eql Mallard::Date.parse("2011-02-13")
        end
    end

    describe "#etwly" do
        it "returns the end of this week last year" do
            @feb.etwly.should eql Mallard::Date.parse("2011-02-19")
        end
    end

    describe "#tdly" do
        it "returns this day last year" do
            @feb.tdly.should eql Mallard::Date.parse("2011-02-18")
        end
    end

    describe "#sty" do
        it "returns the start of this year" do
            @feb.sty.should eql Mallard::Date.parse("2012-01-01")
        end
    end

    describe "#sly" do
        it "returns the start of last year" do
            @feb.sly.should eql Mallard::Date.parse("2011-01-02")
        end
    end

    describe "#jan1ty" do
        it "returns the start of this year" do
            @feb.jan1ty.should eql Mallard::Date.parse("2012-01-01")
        end
    end

    describe "#jan1ly" do
        it "returns the start of last year" do
            @feb.jan1ly.should eql Mallard::Date.parse("2011-01-01")
        end
    end

    describe "#wyear" do
        it "returns the year the week occurs in" do
            @nye.wyear.should eql 2011
            @dec.wyear.should eql 2011
        end
    end

    describe "#wlyear" do
        it "returns the year before the week occurs in" do
            @nye.wlyear.should eql 2010
            @dec.wlyear.should eql 2010
        end
    end

    describe "#week" do
        it "returns the week number" do
            @nye.week.should eql 52
            @nye.week.to_s.should eql '52'  # week had at one point been Rational rather than Fixnum
            @dec.week.should eql 50
        end
    end

    describe "#twly" do
        it "returns the week number from the previous year" do
            @nye.twly.should eql 52
            @dec.twly.should eql 50
        end
    end

    describe "#quarter" do
        it "returns which quarter we're in" do
            Mallard::Date.parse("2012-01-17").quarter.should eql 1
            Mallard::Date.parse("2012-02-17").quarter.should eql 1
            Mallard::Date.parse("2012-03-17").quarter.should eql 1
            Mallard::Date.parse("2012-04-17").quarter.should eql 2
            Mallard::Date.parse("2012-05-17").quarter.should eql 2
            Mallard::Date.parse("2012-06-17").quarter.should eql 2
            Mallard::Date.parse("2012-07-17").quarter.should eql 3
            Mallard::Date.parse("2012-08-17").quarter.should eql 3
            Mallard::Date.parse("2012-09-17").quarter.should eql 3
            Mallard::Date.parse("2012-10-17").quarter.should eql 4
            Mallard::Date.parse("2012-11-17").quarter.should eql 4
            Mallard::Date.parse("2012-12-17").quarter.should eql 4
            Mallard::Date.parse("2013-01-17").quarter.should eql 1
        end
    end

    describe "#stq" do
        it "returns the start of the quarter" do
            Mallard::Date.parse("2012-01-17").stq.should eql Mallard::Date.parse("2012-01-01")
            Mallard::Date.parse("2012-04-17").stq.should eql Mallard::Date.parse("2012-04-01")
            Mallard::Date.parse("2012-07-17").stq.should eql Mallard::Date.parse("2012-07-01")
            Mallard::Date.parse("2012-10-17").stq.should eql Mallard::Date.parse("2012-10-01")
        end
    end

    describe "#etq" do
        it "returns the end of the quarter" do
            Mallard::Date.parse("2012-01-17").etq.should eql Mallard::Date.parse("2012-03-31")
            Mallard::Date.parse("2012-04-17").etq.should eql Mallard::Date.parse("2012-06-30")
            Mallard::Date.parse("2012-07-17").etq.should eql Mallard::Date.parse("2012-09-30")
            Mallard::Date.parse("2012-10-17").etq.should eql Mallard::Date.parse("2012-12-31")
        end
    end
end
