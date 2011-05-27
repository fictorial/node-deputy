compile:
	coffee -c -o lib src/deputy-client.coffee

npm: compile
	npm publish .

clean:
	rm -rf lib

.PHONY: compile npm clean
