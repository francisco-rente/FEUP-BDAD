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


### What does this even mean? Redux
- Can the variable attribute Donation.data be used when checking the expiration date of a product (constraint)? (already mentioned)
- Should the Needy class have any attributes? If so, which ones?
- Should there be a class named Support Requests that interconnects the Needy and Support classes? (already mentioned)
- If we do add the class mentioned above, what type of relation would be most adequate? Triple, association? (already mentioned)

## Possible additions
- Advisor has to approve a given project (association? Attribute??);
- Medical Staff, that allows the creation of a new Support (Health) that may include HealthProducts, Phycology Services etc;
- Variable attribute "priority" that somehow mimics the different levels of priority a person should have on an imaginary "support queue" (each person is assigned one according to their needs);