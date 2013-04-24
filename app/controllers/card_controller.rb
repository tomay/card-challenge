class CardController < ApplicationController
  def get_cardtype(cardstring)
  	cardstring = cardstring.gsub(" ","")
	if cardstring.slice(0) == "4" && (cardstring.length == 13 || cardstring.length == 16)
	  cardtype = "VISA" 
	elsif cardstring.length == 15 && (cardstring.slice(0..1) == "34" || cardstring.slice(0..1) == "37")
	  cardtype = "AMEX" 
	elsif cardstring.length == 16 && (51..55).member?(cardstring.slice(0..1).to_i)
	  cardtype = "MasterCard" 
	elsif cardstring.slice(0..3) == "6011" && cardstring.length == 16
	  cardtype = "Discover"
	else 
	  cardtype = "Unknown"
	end
  end

  def luhn_validation(cardstring)
    card = cardstring.gsub(" ","")
    sum = 0
    i = 1
    card.reverse.each_char {|c|
      val = c.to_i
      next if i == 0
      if i % 2 == 0
        val = c.to_i * 2 
        if val > 9
          val = val.to_s.slice(0).to_i + val.to_s.slice(1).to_i
        end
      end
      sum = sum + val
      i += 1
    }
    validity = sum % 10 == 0 ? "(valid)" : "(invalid)"
  end
end
