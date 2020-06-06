EXTENSION = cidr
DATA = cidr--1.0.sql
REGRESS = cidr

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
