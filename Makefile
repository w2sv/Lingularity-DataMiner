SHELL=/bin/bash

# --------------
# Installing
# --------------
install:
	rm -rf env
	mamba env create -f environment.yml --prefix ./env

# --------------
# Mining
# --------------
download-sentence-data:
	python -m src.online_data.downloading.sentence_data

create-token-maps:
	python -m src.token_maps.create

mine-metadata:
	python -m src.online_data.mine_metadata

# --------------
# Testing
# --------------
test: mypy pytest doctest  # run with -k flag in order to continue in case of recipe failure

mypy:
	mypy src/

pytest:
	coverage run -m pytest -vv tests/ --ignore=tests/metadata_mining

doctest:
	python -m pytest -vv --doctest-modules --doctest-continue-on-failure ./backend/
