.PHONY: examples resumes custom-resumes resumes-docker coverletters coverletters-docker send-resume-docker send-coverletter-docker send-bundle-docker clean

TEX = xelatex
DOCKER_TEX = docker run --rm -i -w "/doc/examples" -v "$$PWD:/doc" texlive/texlive:latest xelatex
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
CUSTOM_DIR = examples/resume_custom
BUILD_DIR = build
ARTIFACTS_DIR = $(BUILD_DIR)/artifacts
DELIVERABLES_DIR = $(BUILD_DIR)/deliverables
DELIVERABLE_RUN_DIR = $(DELIVERABLES_DIR)/$(COMPANY)
COVERLETTER_SOURCE ?= examples/coverletter_custom.tex
COMPANY ?=
RESUME_VARIANT ?= de_en
VALID_RESUME_VARIANTS = de_en da_en de_fr da_fr
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')
CUSTOM_SRCS = $(shell find $(CUSTOM_DIR) -name '*.tex')

ifeq ($(strip $(COMPANY)),)
REQUIRE_COMPANY = @echo "Error: COMPANY is required. Example: make send-bundle-docker COMPANY=acme" && exit 1
else
REQUIRE_COMPANY = @true
endif

ifeq ($(filter $(RESUME_VARIANT),$(VALID_RESUME_VARIANTS)),)
REQUIRE_RESUME_VARIANT = @echo "Error: RESUME_VARIANT must be one of: $(VALID_RESUME_VARIANTS). Example: make send-bundle-docker COMPANY=acme RESUME_VARIANT=da_fr" && exit 1
else
REQUIRE_RESUME_VARIANT = @true
endif

examples: $(foreach x, coverletter cv resume, $x.pdf)
resumes: $(foreach x, resume_de_en resume_da_en resume_de_fr resume_da_fr, $x.pdf)
coverletters: $(foreach x, coverletter_de_en, $x.pdf)
custom-resumes: resumes

resumes-docker:
	mkdir -p $(ARTIFACTS_DIR)
	$(DOCKER_TEX) -output-directory=/doc/$(ARTIFACTS_DIR) -jobname=resume resume.tex
	$(DOCKER_TEX) -output-directory=/doc/$(ARTIFACTS_DIR) -jobname=resume_de_en resume_de_en.tex
	$(DOCKER_TEX) -output-directory=/doc/$(ARTIFACTS_DIR) -jobname=resume_da_en resume_da_en.tex
	$(DOCKER_TEX) -output-directory=/doc/$(ARTIFACTS_DIR) -jobname=resume_de_fr resume_de_fr.tex
	$(DOCKER_TEX) -output-directory=/doc/$(ARTIFACTS_DIR) -jobname=resume_da_fr resume_da_fr.tex

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	mkdir -p $(ARTIFACTS_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(ARTIFACTS_DIR) -jobname=resume resume.tex

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	mkdir -p $(ARTIFACTS_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(ARTIFACTS_DIR) -jobname=cv cv.tex

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	mkdir -p $(ARTIFACTS_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(ARTIFACTS_DIR) -jobname=coverletter coverletter.tex

resume_de_en.pdf: $(EXAMPLES_DIR)/resume_de_en.tex $(CUSTOM_SRCS)
	mkdir -p $(ARTIFACTS_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(ARTIFACTS_DIR) -jobname=resume_de_en resume_de_en.tex

resume_da_en.pdf: $(EXAMPLES_DIR)/resume_da_en.tex $(CUSTOM_SRCS)
	mkdir -p $(ARTIFACTS_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(ARTIFACTS_DIR) -jobname=resume_da_en resume_da_en.tex

resume_de_fr.pdf: $(EXAMPLES_DIR)/resume_de_fr.tex $(CUSTOM_SRCS)
	mkdir -p $(ARTIFACTS_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(ARTIFACTS_DIR) -jobname=resume_de_fr resume_de_fr.tex

resume_da_fr.pdf: $(EXAMPLES_DIR)/resume_da_fr.tex $(CUSTOM_SRCS)
	mkdir -p $(ARTIFACTS_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(ARTIFACTS_DIR) -jobname=resume_da_fr resume_da_fr.tex

coverletter_de_en.pdf: $(ARTIFACTS_DIR)/coverletter_de_en.tex $(CUSTOM_SRCS)
	mkdir -p $(ARTIFACTS_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(ARTIFACTS_DIR) -jobname=coverletter_de_en ../$(ARTIFACTS_DIR)/coverletter_de_en.tex

coverletters-docker:
	mkdir -p $(ARTIFACTS_DIR)
	docker run --rm -i -w "/doc" -v "$$PWD:/doc" texlive/texlive:latest xelatex -output-directory=/doc/$(ARTIFACTS_DIR) -jobname=coverletter $(COVERLETTER_SOURCE)

send-resume-docker:
	$(REQUIRE_COMPANY)
	$(REQUIRE_RESUME_VARIANT)
	mkdir -p $(ARTIFACTS_DIR) $(DELIVERABLE_RUN_DIR)
	$(DOCKER_TEX) -output-directory=/doc/$(ARTIFACTS_DIR) -jobname=resume_$(RESUME_VARIANT) resume_$(RESUME_VARIANT).tex
	cp $(ARTIFACTS_DIR)/resume_$(RESUME_VARIANT).pdf $(DELIVERABLE_RUN_DIR)/$(COMPANY)_resume.pdf

send-coverletter-docker:
	$(REQUIRE_COMPANY)
	mkdir -p $(ARTIFACTS_DIR) $(DELIVERABLE_RUN_DIR)
	docker run --rm -i -w "/doc" -v "$$PWD:/doc" texlive/texlive:latest xelatex -output-directory=/doc/$(ARTIFACTS_DIR) -jobname=coverletter $(COVERLETTER_SOURCE)
	cp $(ARTIFACTS_DIR)/coverletter.pdf $(DELIVERABLE_RUN_DIR)/$(COMPANY)_coverletter.pdf

send-bundle-docker: send-resume-docker send-coverletter-docker
	@echo "Deliverables created in $(DELIVERABLE_RUN_DIR)"

clean:
	rm -rf $(BUILD_DIR)
