.PHONY: examples resumes custom-resumes resumes-docker clean

TEX = xelatex
DOCKER_TEX = docker run --rm -i -w "/doc/examples" -v "$$PWD:/doc" texlive/texlive:latest xelatex
EXAMPLES_DIR = examples
RESUME_DIR = examples/resume
CV_DIR = examples/cv
CUSTOM_DIR = examples/resume_custom
BUILD_DIR = build
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')
CUSTOM_SRCS = $(shell find $(CUSTOM_DIR) -name '*.tex')

examples: $(foreach x, coverletter cv resume, $x.pdf)
resumes: $(foreach x, resume_de_en resume_da_en resume_de_fr resume_da_fr, $x.pdf)
custom-resumes: resumes

resumes-docker:
	mkdir -p $(BUILD_DIR)
	$(DOCKER_TEX) -output-directory=/doc/$(BUILD_DIR) -jobname=resume resume.tex
	$(DOCKER_TEX) -output-directory=/doc/$(BUILD_DIR) -jobname=resume_de_en resume_de_en.tex
	$(DOCKER_TEX) -output-directory=/doc/$(BUILD_DIR) -jobname=resume_da_en resume_da_en.tex
	$(DOCKER_TEX) -output-directory=/doc/$(BUILD_DIR) -jobname=resume_de_fr resume_de_fr.tex
	$(DOCKER_TEX) -output-directory=/doc/$(BUILD_DIR) -jobname=resume_da_fr resume_da_fr.tex

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	mkdir -p $(BUILD_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(BUILD_DIR) -jobname=resume resume.tex

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	mkdir -p $(BUILD_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(BUILD_DIR) -jobname=cv cv.tex

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	mkdir -p $(BUILD_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(BUILD_DIR) -jobname=coverletter coverletter.tex

resume_de_en.pdf: $(EXAMPLES_DIR)/resume_de_en.tex $(CUSTOM_SRCS)
	mkdir -p $(BUILD_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(BUILD_DIR) -jobname=resume_de_en resume_de_en.tex

resume_da_en.pdf: $(EXAMPLES_DIR)/resume_da_en.tex $(CUSTOM_SRCS)
	mkdir -p $(BUILD_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(BUILD_DIR) -jobname=resume_da_en resume_da_en.tex

resume_de_fr.pdf: $(EXAMPLES_DIR)/resume_de_fr.tex $(CUSTOM_SRCS)
	mkdir -p $(BUILD_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(BUILD_DIR) -jobname=resume_de_fr resume_de_fr.tex

resume_da_fr.pdf: $(EXAMPLES_DIR)/resume_da_fr.tex $(CUSTOM_SRCS)
	mkdir -p $(BUILD_DIR)
	cd $(EXAMPLES_DIR) && $(TEX) -output-directory=../$(BUILD_DIR) -jobname=resume_da_fr resume_da_fr.tex

clean:
	rm -rf $(BUILD_DIR)
