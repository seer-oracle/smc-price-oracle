
class Price(object):
    @staticmethod
    def encode(_price_list: list, _price_bit: list):
        if len(_price_bit) != len(_price_list):
            return None
        
        _total_bit = 0
        _encoded = 0

        for i in range(len(_price_list)):
            _encoded |= _price_list[i] << _total_bit
            print(f"{i} : {_encoded}")
            _total_bit += _price_bit[i]

        return _encoded

    @staticmethod
    def decode(price_bit: list, encoded_value):
        _total_bit = 0
        _decoded_vals = []
        for i in range(len(price_bit)):
            _decoded_val = (encoded_value >> _total_bit) & ((1 << price_bit[i]) - 1)
            print(f"{i}: {_decoded_val}")
            _decoded_vals.append(_decoded_val)
            _total_bit += price_bit[i]
        
        return _decoded_vals

vetho = int(1.000 * 10 ** 12)
vet = int(1.000 * 10 ** 12)
vebank = int(1.000 * 10 ** 12)
veusd = int(1.000 * 10 ** 6)
print(vetho)
print(vet)
print(vebank)
print(veusd)

_price_list = [vetho, vet, vebank, veusd]
_price_bit = [57 , 57, 57, 37]
encoded = Price.encode(_price_list, _price_bit)
print('encoded price = ', encoded)
decoded = Price.decode(price_bit=_price_bit, encoded_value=encoded)
print("Decoded list : ", decoded)

# decoded = Price.decode(encoded)
# print(decoded)