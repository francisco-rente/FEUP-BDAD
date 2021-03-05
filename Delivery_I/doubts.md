# Doubts
## Public Doubts
- Is the ID necessary?
- Should data types be included? 
- Where do we find which data types are available?
- Constraints
	- How obvious should constraints be? Can we include Armazem.capacidadeTotal > 0 or DoacaoMonetaria.valor > 0?
	- Do calculated attributes have constraints? E.g. Trabalhador.horasDiarias <= 8, Armazem.capacidadeRestante <= Armazem.capacidadeTotal.
	- Can we use complex types in constraints? E.g. ProdutoAlimentar.dataValidade.
	- Should we include NOT NULL, UNIQUE KEY, etc.?
	- How do we ensure certain restrictions? E.g number of people an advisor can guide at the same time, the number of supports a person can benefit from.
- Should relations always have names or only when it's not obvious?
- Are comment boxes necessary? For what?
- Is Date a built-in type or should we use our class?
- Are we representing Addresses, Locations and Countries correctly?
- Is the adress an attribute or a relation? Shelter, Person, etc.
- Should recurring monetary donations be another class or should we use the monetary donation with frequency=0? Does that create a lot of nulls?
- Can booleans be chosen by us or should gender be a class of it's own?
- Should the food products' type be another class?
- Should we try to include the concept of support requests? If so,
	- How do we relate a request with:
		- The needful person
		- The actual support
		- The administrator responsible
- Is the diagram too complex? Should we reduce classes?

## Private Doubts
- Link administrators with warehouses;
- Products have names;
- Clothing products also have a gender;
- Shelter could have a maximum capacity;
- Volunteers also related to supports?
- Multiplicity in Needy-Support. Same support for multiple people?

## WTF?
### Why are we asking this?
- Maximum capacity in shelter.

### What does this even mean? 
- Donation.data in validation checking, can it be used? 
- Needy attributes 
- Support requests
- Medical Staff
- Help priority status as needy attribute 
- Support request, needy and support- triple???

## Possible additions
- Advisor has to approve a given project (association? Attribute??)
