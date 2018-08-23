module HomesHelper
  def change_second_to_days(t)
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    "#{dd} days, #{hh} hours, #{mm} minutes"
  end
end
