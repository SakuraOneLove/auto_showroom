module HandlingHelper
    # случайное название
    def get_name
        sym = (('a'..'z').to_a + ('1'..'9').to_a).shuffle
        str = ''
        rand(3..6).times { str += sym.sample }
        str
      end

end
