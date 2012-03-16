all: tangle latex exe clean test

latex:
	./tangle intel.pamphlet code >intel.lisp
	latex intel.pamphlet
	latex intel.pamphlet
	dvipdfm intel.dvi

tangle: tangle.c
	gcc -o tangle tangle.c

exe:
	clisp -norc -x '(progn (load "intel.lisp") (saveinitmem "isa" :executable t :norc t :quiet t :init-function (lambda nil (process-args) (ext:exit))))'

test:
	gcc -c tangle.c
	./isa -- elf file="tangle.o" nasm

clean:
	rm -f *.aux *.idx *.log *.toc *~ intel.dvi tangle.o

pristine: clean
	rm -f intel.lisp intel.pdf intel.dvi tangle isa tangle.o

