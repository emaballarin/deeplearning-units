.PHONY: clean
clean:
	find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete -o -type d -name .mypy_cache -delete

.PHONY: format
format:
	find . -type f -name '*.py' -exec reorder-python-imports --py311-plus "{}" \;
	black "$(realpath .)"

.PHONY: deployhooks
deployhooks:
	cp -f ./.githooks/* ./.git/hooks/

.PHONY: precau
precau:
	pre-commit autoupdate

.PHONY: precra
precra:
	pre-commit run --all-files

.PHONY: gitall
gitall:
	git add -A; git commit --all; git push

.PHONY: runlabs
runlabs:
	PYDEVD_DISABLE_FILE_VALIDATION=1 find "./labs/" -type f -name '*.ipynb' -exec jupyter nbconvert --ExecutePreprocessor.timeout=-1 --to notebook --inplace --execute "{}" \;
	find "./labs/" -type f -name '*.pt' -delete -o -type f -name '*.pth' -delete -o -type f -name '*.safetensors' -delete
