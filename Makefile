ASSEMBLIES=$(shell cat assemblies.txt)
DEP_DIR=.deps
STL_DIR=stl
SRC_DIR=src
DIRS=$(DEP_DIR) $(STL_DIR)
CLEANOBJS=$(DEP_DIR) $(STL_DIR)

OBJS=$(patsubst %, $(STL_DIR)/%.stl, $(ASSEMBLIES))
DEPS=$(patsubst %, $(DEP_DIR)/%.d, $(ASSEMBLIES))

target: $(DIRS) $(OBJS)

$(STL_DIR)/%.stl: $(SRC_DIR)/%.scad | $(DIRS)
	openscad -o $@ $< -d $(DEP_DIR)/$*.d

$(DIRS):
	mkdir $(DEP_DIR) $(STL_DIR)

clean:
	rm -rf $(CLEANOBJS)

-include $(DEPS)
