#!/bin/bash

psql -d qwat -c "SELECT qwat_od.fn_update_pipe_crossing()"

psql -d qwat -c "SELECT qwat_od.fn_node_set_type()"

psql -d qwat -c "REFRESH MATERIALIZED VIEW qwat_od.vw_pipe_schema_node;"
