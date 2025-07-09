-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION cidr" to load this file. \quit

CREATE OR REPLACE FUNCTION pg_catalog.cidr(inet, inet) RETURNS TABLE (cidr cidr) AS $$
DECLARE
  minmask CONSTANT inet := netmask(set_masklen($1, 0));
  maxmask CONSTANT inet := ~minmask;
  maxlen CONSTANT int := masklen(maxmask);
  len int;
BEGIN
  IF family($1) <> family($2) THEN
    RAISE EXCEPTION 'cannot merge addresses from different families' USING ERRCODE = 'invalid_parameter_value';
  END IF;

  IF masklen($1) <> maxlen OR masklen($2) <> maxlen THEN
    RAISE EXCEPTION 'cannot merge networks' USING ERRCODE = 'invalid_parameter_value';
  END IF;

  IF $2 < $1 THEN
    RAISE EXCEPTION 'result is out of range' USING ERRCODE = 'numeric_value_out_of_range';
  END IF;

  WHILE $1 <= $2 LOOP
    len := CASE WHEN $1 = minmask THEN 0 ELSE masklen(inet_merge(~$1 & $1 - 1, minmask)) END;
    cidr := set_masklen($1, len);

    WHILE set_masklen(broadcast(cidr), maxlen) > $2 LOOP
      len := len + 1;
      cidr := set_masklen($1, len);
    END LOOP;

    RETURN NEXT;

    $1 := set_masklen(broadcast(cidr), maxlen);
    EXIT WHEN $1 = maxmask;
    $1 := $1 + 1;
  END LOOP;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT PARALLEL SAFE;
