import cantera as ct
# ar = ct.Element('Ar')
# print(ar.weight)

gas = ct.Solution('gri30.xml')
gas()
