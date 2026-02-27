.PHONY: examples resumes custom-resumes clean

TEX = xelatex
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

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	mkdir -p $(BUILD_DIR)
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=resume $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	mkdir -p $(BUILD_DIR)
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=cv $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	mkdir -p $(BUILD_DIR)
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=coverletter $<

resume_de_en.pdf: $(EXAMPLES_DIR)/resume_de_en.tex $(CUSTOM_SRCS)
	mkdir -p $(BUILD_DIR)
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=resume_de_en $<

resume_da_en.pdf: $(EXAMPLES_DIR)/resume_da_en.tex $(CUSTOM_SRCS)
	mkdir -p $(BUILD_DIR)
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=resume_da_en $<

resume_de_fr.pdf: $(EXAMPLES_DIR)/resume_de_fr.tex $(CUSTOM_SRCS)
	mkdir -p $(BUILD_DIR)
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=resume_de_fr $<

resume_da_fr.pdf: $(EXAMPLES_DIR)/resume_da_fr.tex $(CUSTOM_SRCS)
	mkdir -p $(BUILD_DIR)
	$(TEX) -output-directory=$(BUILD_DIR) -jobname=resume_da_fr $<

clean:
	rm -rf $(BUILD_DIR)
