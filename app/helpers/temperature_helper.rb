module TemperatureHelper
  def to_fahreinheit(temp)
    fahreinheit = (temp.to_f * 9.fdiv(5) - 459.67).round(2)

    "#{fahreinheit} °F"
  end
end
