MODULE_TOPDIR = ../..

PGM = r.learn.ml

ETCFILES = rlearn_utils rlearn_crossval rlearn_rasters rlearn_sampling

include $(MODULE_TOPDIR)/include/Make/Script.make
include $(MODULE_TOPDIR)/include/Make/Python.make

default: script
