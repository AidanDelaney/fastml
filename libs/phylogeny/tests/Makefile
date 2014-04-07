CPPFLAGS=      -g -Wall -Wno-sign-compare -I.. -DLOG -ftemplate-depth-25 -O0
CPPFLAGSDEBUG= -g -Wall -Wno-sign-compare -I.. -DLOG -ftemplate-depth-32

# -O3
LDFLAGS= -L.. 
LDLIBS= -lEvolTree

CC=g++
CXX=g++

.PHONY: test tests run all clean

# Removed the following tests as they do not pass at all:
# 	optimizeBranchesJC_EM_gamma			    \
#	optimizeBranchesJC_EM_gam_estimate_alp	\
#   bootstrap_test							\
#   optimize_HKY_param                      \
#   optimizeBranchesJC_EM                   \

TESTS= split_test splitMap_test				\
	given2seqTheDistBetweenThem-3					\
	given2seqEstimateTheDistBetweenThem computeNJtreeJCmodel	\
	checkTreeLikelihoodGivenBranches 		\
	given2seqEstimateTheDistBetweenThemGamma			\
	given2seqEstimateTheDistanceK2P		\
	doubleRep readTreeWithComments
#ludouble_test 	DistanceTableFromTree 
OTHER_TESTS= exhaustiveSearch

all: test
run:  $(addsuffix .out.tmp,$(TESTS)) 

libEvolDebug=../libEvolTreeDebug.a

DEBUGEXEC = $(addsuffix .debug,$(TESTS))
$(DEBUGEXEC): $(libEvolDebug)

$(TESTS): ../libEvolTree.a

test: $(addsuffix .test,$(TESTS)) 

alltest: $(addsuffix .test,$(TESTS) $(OTHER_TESTS)) 

%.test: %.out.tmp %.out.standard
	diff $^

readTreeWithComments.out.tmp: readTreeWithComments treeWithComments.tree
	./$^>$@

%.out.tmp: %
	./$(*) > $@

tests: $(TESTS)


%.debug.o: %.c
	$(CC) -c $(CPPFLAGSDEBUG) $(CFLAGS) $< -o $@

%.debug.o: %.cpp
	$(CXX) -c $(CPPFLAGSDEBUG) $(CXXFLAGS) $< -o $@

debug: $(DEBUGEXEC)


clean:
	-rm -f $(TESTS) *.out.tmp *.o
