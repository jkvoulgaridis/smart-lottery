
new-contract:
	cd lottery-contract && truffle create contract $(contract)
new-test:
	cd lottery-contract && truffle create test $(test)
